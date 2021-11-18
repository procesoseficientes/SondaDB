CREATE TABLE [acsa].[SWIFT_PRICE_LIST_BY_SKU_BK] (
    [CODE_PRICE_LIST] VARCHAR (25)    NOT NULL,
    [CODE_SKU]        VARCHAR (50)    NOT NULL,
    [COST]            NUMERIC (18, 2) NULL,
    [CODE_PACK_UNIT]  VARCHAR (25)    NULL,
    [UM_ENTRY]        INT             NULL
);

