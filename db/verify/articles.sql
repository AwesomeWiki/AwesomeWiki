-- Verify awesome:articles on pg

BEGIN;

SELECT pg_catalog.has_table_privilege('api.articles', 'select');

DO $$
DECLARE
    t varchar;
    u varchar;
BEGIN
   t := (SELECT title from api.articles where fqn = 'pylint' and language = 'python' and url = 'http://www.blog.pythonlibrary.org/2012/06/12/pylint-analyzing-python-code/');
   ASSERT t = 'PyLint: Analyzing Python Code';
   u := (SELECT url FROM api.articles WHERE fqn = 'keras' and language = 'python'  and title = 'Building an AlphaZero AI using Python and Keras');
   ASSERT u = 'https://applied-data.science/blog/how-to-build-your-own-alphazero-ai-using-python-and-keras/';
   
   t := (SELECT title from api.articles where fqn = 'bit' and language = 'javascript' and url = 'http://forum.bitcoin.org/index.php?topic=9042.0');
   ASSERT t = 'Javascript Bitcoin Miner';
   u := (SELECT url FROM api.articles WHERE fqn = 'bit' and language = 'javascript' and title = 'Mu – 10-bit JavaScript Computer');
   ASSERT u = 'https://github.com/bucaran/mu';
END $$;


ROLLBACK;
