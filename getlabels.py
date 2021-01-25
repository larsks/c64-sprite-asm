import requests
import time

from itertools import zip_longest
from lxml import etree

url = 'https://www.pagetable.com/c64ref/kernal/'

res = requests.get(url)
res.raise_for_status()

parser = etree.HTMLParser()
doc = etree.fromstring(res.text, parser)

table = doc.cssselect('#disassembly_table')[0]

date = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime())
print(f'; from: {url}')
print(f'; on:   {date}')

names = []
for tr in table.xpath('tr'):
    th = tr.xpath('th')
    td = tr.xpath('td')

    if th[0].text == 'Address':
        continue

    addr = th[0].xpath('string()').strip()
    name = th[1].text.strip()
    summary = td[0].xpath('string()').strip().splitlines()[0]

    names.append(name)

    print(f'{name:16}{"=":16}{addr:16} ; {summary}')

print()
namei = iter(names)
for chunk in zip_longest(*[namei]*5):
    exports = ','.join(x for x in chunk if x)
    print(f'{"":16}{".export":16}{exports}')
