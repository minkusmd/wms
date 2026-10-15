#!/bin/bash
# $1 = prefix pentru capturile dispeceratului (w1_disp / w2_disp); $2 = "all" pentru celelalte forme
W="$CLAUDE_JOB_DIR/tmp/wmsshot"
S=/d/Projects/MyProjects/WMS/sources/classes
export FBDOC_PW=$(grep -E "^FB_TEST_SYSDBA_PASSWORD=" /d/Projects/MyProjects/WMS/CurieriWMS/.env | cut -d= -f2- | tr -d '\r"')
OUT=$(cygpath -w "$CLAUDE_JOB_DIR/tmp/doc/shots")
cd "$W"
./WmsShot.exe dispatch "$(cygpath -w $S/Dispatch/frmDispatchDialog.dfm)" "$OUT" 9301 "$1" "${4:-9201}" all "${3:-0}"
if [ "$2" = "all" ]; then
  ./WmsShot.exe couriers "$(cygpath -w $S/Dispatch/frmDispatchCouriersDialog.dfm)" "$OUT" 9301
  ./WmsShot.exe zones "$(cygpath -w $S/Dispatch/frmDispatchZonesDialog.dfm)" "$OUT" 9301
  ./WmsShot.exe rules "$(cygpath -w $S/SupplierPickup/frmSupplierOrderRulesDialog.dfm)" "$OUT" 9301
  ./WmsShot.exe pickupconfirm "$(cygpath -w $S/SupplierPickup/frmSupplierPickupConfirmDialog.dfm)" "$OUT" 9301
  ./WmsShot.exe delivery "$(cygpath -w /d/Projects/MyProjects/WMS/sources/Tools/Delivery/frameDocsDeliveryUnit.dfm)" "$OUT" 9301
fi
./WmsShot.exe pickuplist "$(cygpath -w $S/SupplierPickup/frmSupplierPickupListDialog.dfm)" "$OUT" 9301 "$1"
