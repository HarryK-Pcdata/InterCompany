-- ============================================================
-- SHIPMENT table audit logging
-- Sequence and log table (already exists in database)
-- ============================================================

-- CREATE SEQUENCE SEQ_SHIPMENT_LOG
--   START WITH 1
--   INCREMENT BY 1
--   NOCACHE
--   NOCYCLE;

-- CREATE TABLE SHIPMENT_LOG (
--   LOG_ID          NUMBER        NOT NULL,
--   ACTION          VARCHAR2(10)  NOT NULL,  -- 'INSERT', 'UPDATE', 'DELETE'
--   LOG_DATE        DATE          NOT NULL,
--   LOG_USER        VARCHAR2(100) NOT NULL,
--   SHIPMENTID      VARCHAR2(50),
--   OLD_STATUS      VARCHAR2(50),
--   NEW_STATUS      VARCHAR2(50),
--   OLD_DMSCANNING  VARCHAR2(1),
--   NEW_DMSCANNING  VARCHAR2(1),
--   OLD_SHIPDATE    DATE,
--   NEW_SHIPDATE    DATE,
--   OLD_HASBEENCOPIED VARCHAR2(1),
--   NEW_HASBEENCOPIED VARCHAR2(1),
--   CONSTRAINT PK_SHIPMENT_LOG PRIMARY KEY (LOG_ID)
-- );

-- ============================================================
-- INSERT trigger (existing)
-- ============================================================
CREATE OR REPLACE TRIGGER TRG_SHIPMENT_INS
  AFTER INSERT ON SHIPMENT
  FOR EACH ROW
BEGIN
  INSERT INTO SHIPMENT_LOG (
    LOG_ID,
    ACTION,
    LOG_DATE,
    LOG_USER,
    SHIPMENTID,
    NEW_STATUS,
    NEW_DMSCANNING,
    NEW_SHIPDATE,
    NEW_HASBEENCOPIED
  ) VALUES (
    SEQ_SHIPMENT_LOG.NEXTVAL,
    'INSERT',
    SYSDATE,
    USER,
    :NEW.SHIPMENTID,
    :NEW.STATUS,
    :NEW.DMSCANNING,
    :NEW.SHIPDATE,
    :NEW.HASBEENCOPIED
  );
END TRG_SHIPMENT_INS;
/

-- ============================================================
-- UPDATE trigger
-- ============================================================
CREATE OR REPLACE TRIGGER TRG_SHIPMENT_UPD
  AFTER UPDATE ON SHIPMENT
  FOR EACH ROW
BEGIN
  INSERT INTO SHIPMENT_LOG (
    LOG_ID,
    ACTION,
    LOG_DATE,
    LOG_USER,
    SHIPMENTID,
    OLD_STATUS,
    NEW_STATUS,
    OLD_DMSCANNING,
    NEW_DMSCANNING,
    OLD_SHIPDATE,
    NEW_SHIPDATE,
    OLD_HASBEENCOPIED,
    NEW_HASBEENCOPIED
  ) VALUES (
    SEQ_SHIPMENT_LOG.NEXTVAL,
    'UPDATE',
    SYSDATE,
    USER,
    :NEW.SHIPMENTID,
    :OLD.STATUS,
    :NEW.STATUS,
    :OLD.DMSCANNING,
    :NEW.DMSCANNING,
    :OLD.SHIPDATE,
    :NEW.SHIPDATE,
    :OLD.HASBEENCOPIED,
    :NEW.HASBEENCOPIED
  );
END TRG_SHIPMENT_UPD;
/

-- ============================================================
-- DELETE trigger
-- ============================================================
CREATE OR REPLACE TRIGGER TRG_SHIPMENT_DEL
  AFTER DELETE ON SHIPMENT
  FOR EACH ROW
BEGIN
  INSERT INTO SHIPMENT_LOG (
    LOG_ID,
    ACTION,
    LOG_DATE,
    LOG_USER,
    SHIPMENTID,
    OLD_STATUS,
    OLD_DMSCANNING,
    OLD_SHIPDATE,
    OLD_HASBEENCOPIED
  ) VALUES (
    SEQ_SHIPMENT_LOG.NEXTVAL,
    'DELETE',
    SYSDATE,
    USER,
    :OLD.SHIPMENTID,
    :OLD.STATUS,
    :OLD.DMSCANNING,
    :OLD.SHIPDATE,
    :OLD.HASBEENCOPIED
  );
END TRG_SHIPMENT_DEL;
/
