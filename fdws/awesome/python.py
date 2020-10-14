import multicorn
import redis
import requests, re, json, sys
from slugify import slugify
import urllib.request
from .alist import getAllParsedData

#Cite from https://www.powercms.in/blog/how-get-json-data-remote-url-python-script with some modifications
def findPackageFromPyPi(package):
    url = 'https://pypi.python.org/pypi/' + package + '/json'
    response = urllib.request.urlopen(url)
    result = json.loads(response.read())
    result.pop('urls')
    result.pop('last_serial')
    info = json.dumps(result)
    return info

class Package(multicorn.ForeignDataWrapper):
    def __init__(self, options, columns):
        super(Package, self).__init__(options,columns)
        self.columns = columns
        self.options = options
        self.redis = redis.Redis(host='localhost', port=6379, db=0, decode_responses=True)
    
    def execute(self, quals, columns):
        # quals is an array of multicorn.Qual
        # https://github.com/Segfault-Inc/Multicorn/blob/ba4843de90e47dc3d9df2902cefab1c6fe9e1110/python/multicorn/__init__.py#L52
        
        fqn_qual = None

        for qual in quals:
            if qual.field_name == 'fqn' and qual.operator == '=':
                fqn_qual = qual
                break
        
        if fqn_qual is None:
            raise Exception("You must provide an FQN for a library to query this endpoint")

        fqn_name = fqn_qual.value

        categories = getAllParsedData(self)

        line = {}

        for category, catList in categories.items():
            for library in catList:
                matches = re.match(r'^\[(.*)\]\((.*)\)$', library)
                if not matches:
                    continue
                libName, url = matches.groups()
                fqn = slugify(libName)

                if fqn != fqn_name:
                    continue
                
                line['category_slug'] = slugify(category.strip())
                line['name'] = libName
                line['fqn'] = slugify(libName)
                line['url'] = url
                line['info'] = findPackageFromPyPi(fqn)

                break
            if 'name' in line: break
        

        yield line
