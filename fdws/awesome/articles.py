import multicorn
import redis
import requests, re, json, sys
from slugify import slugify

class HackerNews(multicorn.ForeignDataWrapper):
    def __init__(self, options, columns):
        super(HackerNews, self).__init__(options,columns)
        self.columns = columns
        self.options = options
        self.redis = redis.Redis(host='localhost', port=6379, db=0, decode_responses=True)
    
    def execute(self, quals, columns):
        # quals is an array of multicorn.Qual
        # https://github.com/Segfault-Inc/Multicorn/blob/ba4843de90e47dc3d9df2902cefab1c6fe9e1110/python/multicorn/__init__.py#L52
        
        fqn_qual = None
        lang_qual = None

        for qual in quals:
            if qual.field_name == 'fqn' and qual.operator == '=':
                fqn_qual = qual
            elif qual.field_name == 'language' and qual.operator == '=':
                lang_qual = qual

        if lang_qual is None:
            raise Exception("You must provide a language to query this endpoint")
        
        if fqn_qual is None:
            raise Exception("You must provide an FQN for a library to query this endpoint")

        fqn_name = fqn_qual.value.lower()
        lang_name = lang_qual.value.lower()


        query = lang_name+" "+fqn_name

        searchResults = requests.get("https://hn.algolia.com/api/v1/search", params={
            'tags': 'story',
            'hitsPerPage': 100,
            'query': query
        }).json()['hits']

        searchResults = filter(lambda result: fqn_name in result['title'].lower() and lang_name in result['title'].lower(), searchResults)

        for result in searchResults:
            line = {}

            line['language'] = lang_qual.value
            line['fqn'] = fqn_qual.value
            line['title'] = result['title']
            line['url'] = result['url']
            # TODO add timestamp

            yield line