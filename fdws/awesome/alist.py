import multicorn
import requests, re, json
import redis
from slugify import slugify

REDIS_CACHE_TIME = 300

def parseMarkdown(markdown):
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

def getAllParsedData(fdw):
    redis_key = "alist:{repo}".format(repo = fdw.options['repo'])
    json_parsed_data = fdw.redis.get(redis_key)

    if not json_parsed_data:
        url = "https://github.com/{repo}/raw/master/README.md".format(repo = fdw.options['repo'])
        markdown = requests.get(url).text
        parsed_data = parseMarkdown(markdown)
        fdw.redis.setex(redis_key, REDIS_CACHE_TIME, json.dumps(parsed_data))
    else:
        parsed_data = json.loads(json_parsed_data)

    return parsed_data

def getCategoriesParsedData(fdw):
    redis_key = "alist:{repo}:categories".format(repo = fdw.options['repo'])
    json_parsed_categories = fdw.redis.get(redis_key)

    if not json_parsed_categories:
        all_parsed_data = getAllParsedData(fdw)
        categories = set()

        for category_name in all_parsed_data:
            if category_name not in categories:
                categories.add(category_name)
        
        unsorted_categories = list(map(lambda n: {'name': n.strip(), 'slug': slugify(n.strip())}, categories))
        parsed_categories = sorted(unsorted_categories, key=lambda c: c['slug'])
        fdw.redis.setex(redis_key, REDIS_CACHE_TIME, json.dumps(parsed_categories))
    else:
        parsed_categories = json.loads(json_parsed_categories)
    
    return parsed_categories

class Categories(multicorn.ForeignDataWrapper):
    def __init__(self, options, columns):
        super(Categories, self).__init__(options,columns)
        self.columns = columns
        self.options = options
        self.redis = redis.Redis(host='localhost', port=6379, db=0, decode_responses=True)
    
    def execute(self, quals, columns):
        categories = getCategoriesParsedData(self)

        for category in categories:
            yield category # name, slug

class ForeignDataWrapper(multicorn.ForeignDataWrapper):

    def __init__(self, options, columns):
        super(ForeignDataWrapper, self).__init__(options, columns)
        self.columns = columns
        self.options = options
        self.redis = redis.Redis(host='localhost', port=6379, db=0, decode_responses=True)
        
    def execute(self, quals, columns):
        parsed = getAllParsedData(self)

        for category, catList in parsed.items():
            for lib in catList:
                line = {}
                line['category_slug'] = slugify(category.strip())
                matches = re.match(r'^\[(.*)\]\((.*)\)$', lib)
                if not matches:
                    continue
                libName, url = matches.groups()
                line['name'] = libName
                line['url'] = url
                yield line
    
    