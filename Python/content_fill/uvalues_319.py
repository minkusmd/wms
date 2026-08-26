# -*- coding: utf-8 -*-
"""Valorile distincte pe care le da Ultra pentru proprietatile de frigider care
trebuie potrivite cu dictionarul catalogului."""
import firebird.driver as fb, io, json

PROPS = ['Tip frigider', 'Tip instalare', 'Amplasare congelator', 'Tip control',
         'Clasa energetică', 'Clasa de eficiență energetică', 'Sistem dezghețare congelator',
         'Sistem dezghețare frigider', 'Supercongelare', 'Materialul rafturilor', 'Culoare',
         'Numărul de camere', 'Numărul de compresoare', 'Număr compartimente în congelator',
         'Înălţime {cm}', 'Lăţime {cm}', 'Adâncime {cm}', 'Greutate {kg}',
         'Volumul total util{l}', 'Volumul util al frigiderului {l}',
         'Volumul util al congelatorului {l}', 'Nivel de zgomot maxim {dB}',
         'Capacitate de congelare {kg /zi}', 'Consum anual energie{kWh}',
         'Pastrarea autonomă a frigului {ore}']

link = json.load(io.open('ultra_link_319.json', encoding='utf-8'))
uuids = "','".join(v['uuid'] for v in link.values())
con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor(); out = io.open('uvalues_319.txt', 'w', encoding='utf-8')
for p in PROPS:
    cur.execute("""SELECT v.VALUE_RO, v.VALUE_RU, COUNT(*) n
                   FROM TS_ULTRA2_PROPERTY_VALUE v
                   JOIN TS_ULTRA2_PROPERTY pr ON pr.CODE=v.PROPERTY_CODE
                   WHERE pr.NAME_RO=? AND v.PRODUCT_UUID IN ('%s')
                   GROUP BY 1,2 ORDER BY 3 DESC""" % uuids, (p,))
    rows = cur.fetchall()
    out.write("\n%s  (%d valori distincte)\n" % (p, len(rows)))
    for v, vru, n in rows[:14]:
        out.write("    %-32s | %-26s %d\n" % ((v or '')[:32], (vru or '')[:26], n))
out.close(); con.close(); print('ok')
