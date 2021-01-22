import json
import sys

with (open(sys.argv[1]) if len(sys.argv) > 0 else sys.stdin) as fd:
    sprites = json.load(fd)

print('; DO NOT EDIT (this file was generated automatically)')
names = []
for sprite in sprites['sprites']:
    names.append(sprite['name'])
    print(f'{"":16}{".segment":16}"GFXDATA"')
    print(f'{"":16}{".align":16}$40')
    print(f'{sprite["name"]}:')
    for row in sprite['pixels']:
        rowi = iter(row)
        chunks = zip(*[rowi]*8)

        print(f'{"":16}{".byte":16}', end='')
        print(','.join('%{}'.format(''.join(f'{x}' for x in chunk)) for chunk in chunks))

    print(f'{"":16}{".segment":16}"DATA"')
    label = f'{sprite["name"]}_color'
    names.append(label)
    label = f'{label}:'
    print(f'{label:16}{".byte":16}${sprite["color"]:02X}')

    print()
    for name in names:
        print(f'{"":16}{".export":16}{name}')
