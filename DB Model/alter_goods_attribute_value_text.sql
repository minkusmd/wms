/* ============================================================================
   Migrare TS_GOODS_ATTRIBUTE: valoarea pe produs devine TEXT (VALUE_RO/VALUE_RU),
   in loc de VALUEID (FK la TS_ATTRIBUTE_VALUE).

   Dictionarul TS_ATTRIBUTE_VALUE RAMANE (sursa de selectie in UI); pe produs se
   stocheaza textul ales, "inghetat" istoric.

   Tabela nu are inca date (atribuirea pe produs nu e implementata), deci
   drop + create curat. A se rula pe baza SW.
   ============================================================================ */

DROP TABLE TS_GOODS_ATTRIBUTE;

CREATE TABLE TS_GOODS_ATTRIBUTE (
    GOODSID  INTEGER NOT NULL,
    ATTRID   INTEGER NOT NULL,
    VALUE_RO VARCHAR(256),
    VALUE_RU VARCHAR(256)
);
ALTER TABLE TS_GOODS_ATTRIBUTE
    ADD CONSTRAINT PK_TS_GOODS_ATTRIBUTE PRIMARY KEY (GOODSID, ATTRID);
ALTER TABLE TS_GOODS_ATTRIBUTE
    ADD CONSTRAINT FK_TS_GOODS_ATTR_GOODS
    FOREIGN KEY (GOODSID) REFERENCES TS_GOODS (GOODSID);
ALTER TABLE TS_GOODS_ATTRIBUTE
    ADD CONSTRAINT FK_TS_GOODS_ATTR_ATTR
    FOREIGN KEY (ATTRID) REFERENCES TS_ATTRIBUTE (ATTRID);
CREATE INDEX IDX_TS_GOODS_ATTR_ATTR ON TS_GOODS_ATTRIBUTE (ATTRID);
