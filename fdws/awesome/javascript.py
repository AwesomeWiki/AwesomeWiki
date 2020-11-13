import multicorn
import redis
import requests, re, json, sys
from slugify import slugify
import urllib.request
import urllib
from urllib.request import Request, urlopen
from .alist import getAllParsedData
import sys
sys.path.insert(0, '/var/AwesomeWiki/library_scraper')
from markdown import getPackageName


def findPackageFromNPM(package):
    try:
        url = 'https://registry.npmjs.org/' + package
        response = urllib.request.urlopen(url)
        result = json.loads(response.read())
        result.pop('versions')
        result.pop('users')
        result.pop('readme')
        info = json.dumps(result)
    except:
        return None
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
                names = str(library[0])
                matches = re.match(r'^\[(.*)\]\((.*)\)$', names)
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
                package_info = findPackageFromNPM(fqn)
                if package_info is None:
                    package_name = getPackageName(
                        url, search_expr="npm\sinstall\s((?:-U\s)?([\w-]+))")
                    if package_name is None:
                        err = '{ "error":"There is a timeout from webscraping"}'
                        err_json = json.loads(err)
                        line['metadata'] = err_json
                    else:
                        package_info = findPackageFromNPM(package_name)
                        line['metadata'] = package_info
                else:
                    line['metadata'] = package_info

                break
            if 'name' in line: break
        

        yield line
