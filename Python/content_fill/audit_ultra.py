# -*- coding: utf-8 -*-
"""Verificari automate asupra descrierilor generate din Ultra + comparatie cu
valorile deduse din denumirea produsului (pentru a prinde potriviri gresite)."""
import io, json, re
import parse_cpu

gen = json.load(io.open('gen_dsc_ultra.json', encoding='utf-8'))
out = io.open('audit_ultra.txt', 'w', encoding='utf-8')

def field(text, label):
    m = re.search(r'^%s: (.+)$' % re.escape(label), text, re.M)
    return m.group(1).strip() if m else None

anomalii, diferente = [], []
for gid, v in gen.items():
    ro = v['ro']
    # 1) valori numerice implauzibile
    for lbl, lo, hi in [('Numărul nucleelor', 1, 96), ('Numărul threads', 1, 192)]:
        val = field(ro, lbl)
        if val and val.isdigit() and not (lo <= int(val) <= hi):
            anomalii.append((gid, lbl, val))
    fr = field(ro, 'Frecvenţa procesor')
    if fr:
        nums = [float(x) for x in re.findall(r'[\d.]+', fr)]
        if any(n > 7 or n < 0.5 for n in nums) or (len(nums) == 2 and nums[1] <= nums[0]):
            anomalii.append((gid, 'Frecvenţa procesor', fr))
    if not field(ro, 'CPU Socket'):
        anomalii.append((gid, 'CPU Socket', 'lipsa'))

    # 2) comparatie cu denumirea produsului
    s = parse_cpu.parse(v['title'])
    for key, lbl in [('cores', 'Numărul nucleelor'), ('threads', 'Numărul threads')]:
        val = field(ro, lbl)
        if s.get(key) and val and val.isdigit() and int(val) != int(s[key]):
            diferente.append((gid, lbl, s[key], val, v['title'][:60]))
    if s.get('socket') and field(ro, 'CPU Socket'):
        a = s['socket'].replace(' ', '').upper(); b = field(ro, 'CPU Socket').replace(' ', '').upper()
        if a != b:
            diferente.append((gid, 'socket', s['socket'], field(ro, 'CPU Socket'), v['title'][:60]))
    # grafica: sufix F/KF vs ce zice Ultra
    model = (s.get('model') or '').upper()
    if re.search(r'(KF|[0-9]F)$', model):
        if 'nu are grafică integrată' not in ro:
            diferente.append((gid, 'igpu(F/KF)', 'fara', field(ro, 'Procesorul grafic'), v['title'][:60]))

out.write("ANOMALII (valori implauzibile) — %d\n" % len(anomalii))
for a in anomalii:
    out.write("  %s  %s = %s\n" % a)
out.write("\nDIFERENTE fata de denumirea produsului — %d\n" % len(diferente))
for gid, k, from_title, from_ultra, title in diferente:
    out.write("  %s %-12s titlu=%-10s ultra=%-24s %s\n" % (gid, k, from_title, from_ultra, title))
out.close()
print('anomalii', len(anomalii), 'diferente', len(diferente))
