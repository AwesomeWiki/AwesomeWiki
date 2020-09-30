import multicorn
import requests, re, json
import redis

class ForeignDataWrapper(multicorn.ForeignDataWrapper):

    def __init__(self, options, columns):
        super(ForeignDataWrapper, self).__init__(options, columns)
        self.columns = columns
        self.options = options
        self.redis = redis.Redis(host='localhost', port=6379, db=0, decode_responses=True)

    def getParsedData(self):
        redis_key = "alist:{repo}".format(repo = self.options['repo'])
        json_parsed_data = self.redis.get(redis_key)

        if not json_parsed_data:
            url = "https://github.com/{repo}/raw/master/README.md".format(repo = self.options['repo'])
            markdown = requests.get(url).text
            parsed_data = self.parseMarkdown(markdown)
            self.redis.set(redis_key, json.dumps(parsed_data))
            self.redis.expire(redis_key, 300) # cache for 5 minutes
        else:
            parsed_data = json.loads(json_parsed_data)

        return parsed_data

    def execute(self, quals, columns):
        parsed = self.getParsedData()        

        for category, catList in parsed.items():
            for lib in catList:
                line = {}
                line['category_name'] = category.strip()
                matches = re.match(r'^\[(.*)\]\((.*)\)$', lib)
                if not matches:
                    continue
                libName, url = matches.groups()
                line['name'] = libName
                line['url'] = url
                yield line
    
    def parseMarkdown(self, markdown):
        my_dict = {}
        process = False
        lines = markdown.split('\n')
        key = ""
        values = []
        list1 = []
        for line in lines:
            if line == '\n':
                continue
            words = line.split()
            if len(words) == 0:
                continue
            if words[0].startswith('##'):
                new_string = line.replace('##', '')
                if not process:
                    process = True
                else:
                    newList = tuple(values)
                    my_dict[key] = newList
                key = new_string
                values = []
                list1.append(new_string)
            elif len(words) >= 3:
                if words[1].startswith('[') and process:
                    values.append(words[1])
        newList = tuple(values)
        my_dict[key] = newList

        return my_dict