BEGIN EXECUTE IMMEDIATE 'DROP TABLE PARKING_UNNORMALIZED'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE FEE'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE TRACKING'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE SLOT'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE VEHICLE'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE AREA'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

CREATE TABLE PARKING_UNNORMALIZED (
    AreaID        VARCHAR2(5),
    AreaName      VARCHAR2(15),
    Address       VARCHAR2(30),
    Capacity      NUMBER(4),

    SlotID        VARCHAR2(10),
    SlotStatus    VARCHAR2(10),

    VehicleID     NUMBER,
    Plate         VARCHAR2(15),
    VType         VARCHAR2(10),
    OwnerName     VARCHAR2(25),
    ContactNo     VARCHAR2(12),

    TrackingID    NUMBER,
    EntryTime     DATE,
    ExitTime      DATE,
    DurationHrs   NUMBER(6,2),

    FeeID         NUMBER,
    HourlyRate    NUMBER(6,2),
    TotalFee      NUMBER(8,2)
);

CREATE TABLE AREA (
    AreaID       VARCHAR2(5)   NOT NULL,
    AreaName     VARCHAR2(10)  NOT NULL,
    Address      VARCHAR2(20),
    Capacity     NUMBER(4)     DEFAULT 0 NOT NULL,
    CONSTRAINT PK_AREA_1 PRIMARY KEY (AreaID),
    CONSTRAINT CK_AREA_CAP_1 CHECK (Capacity >= 0)
);

CREATE TABLE VEHICLE (
    VehicleID    NUMBER NOT NULL,
    Plate        VARCHAR2(15)  NOT NULL,
    VType        VARCHAR2(5)   DEFAULT 'Car' NOT NULL,
    OwnerName    VARCHAR2(20),
    ContactNo    VARCHAR2(12),
    CONSTRAINT PK_VEHICLE_1 PRIMARY KEY (VehicleID),
    CONSTRAINT UQ_VEHICLE_PLATE_1 UNIQUE (Plate),
    CONSTRAINT CK_VEHICLE_TYPE_1 CHECK (VType IN ('Car','Bike','Truck','Van','Bus'))
);

CREATE TABLE SLOT (
    SlotID       VARCHAR2(10)  NOT NULL,
    AreaID       VARCHAR2(5)   NOT NULL,
    SlotStatus   VARCHAR2(10)  DEFAULT 'Available' NOT NULL,
    CONSTRAINT PK_SLOT_1 PRIMARY KEY (SlotID),
    CONSTRAINT FK_SLOT_AREA_1 FOREIGN KEY (AreaID)
        REFERENCES AREA(AreaID),
    CONSTRAINT CK_SLOT_STATUS_1 CHECK (SlotStatus IN ('Available','Occupied','Reserved'))
);

CREATE TABLE TRACKING (
    TrackingID   NUMBER NOT NULL,
    SlotID       VARCHAR2(10)  NOT NULL,
    VehicleID    NUMBER        NOT NULL,
    EntryTime    DATE          DEFAULT SYSDATE NOT NULL,
    ExitTime     DATE,
    DurationHrs  NUMBER(6,2),
    CONSTRAINT PK_TRACKING_1 PRIMARY KEY (TrackingID),
    CONSTRAINT FK_TRACKING_SLOT_1 FOREIGN KEY (SlotID)
        REFERENCES SLOT(SlotID),
    CONSTRAINT FK_TRACKING_VEHICLE_1 FOREIGN KEY (VehicleID)
        REFERENCES VEHICLE(VehicleID),
    CONSTRAINT CK_TRACKING_TIME_1 CHECK (ExitTime IS NULL OR ExitTime > EntryTime),
    CONSTRAINT CK_TRACKING_DUR_1 CHECK (DurationHrs IS NULL OR DurationHrs >= 0)
);

CREATE TABLE FEE (
    FeeID        NUMBER NOT NULL,
    TrackingID   NUMBER        NOT NULL,
    HourlyRate   NUMBER(6,2)   NOT NULL,
    TotalFee     NUMBER(8,2),
    CONSTRAINT PK_FEE_1 PRIMARY KEY (FeeID),
    CONSTRAINT FK_FEE_TRACKING_1 FOREIGN KEY (TrackingID)
        REFERENCES TRACKING(TrackingID),
    CONSTRAINT UQ_FEE_TRACKING_1 UNIQUE (TrackingID),
    CONSTRAINT CK_FEE_RATE_1 CHECK (HourlyRate >= 0),
    CONSTRAINT CK_FEE_TOTAL_1 CHECK (TotalFee IS NULL OR TotalFee >= 0)
);

-- PARKING_UNNORMALIZED
INSERT INTO PARKING_UNNORMALIZED VALUES ('A001','I8','Block-A Sector I8',50,'S001','Occupied',1,'GAK-882','Car','Hamza Ali','0300-1234567',1,TO_DATE('2026-05-01 08:00','YYYY-MM-DD HH24:MI'),TO_DATE('2026-05-01 10:30','YYYY-MM-DD HH24:MI'),2.50,1,50,125);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A002','Saddar','Block-B Saddar',40,'S002','Occupied',2,'LWF-687','Bike','Shaheer Jawad','0311-2345678',16,TO_DATE('2026-05-13 08:00','YYYY-MM-DD HH24:MI'),NULL,NULL,16,30,NULL);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A003','F9','Block-C F9',30,'S003','Occupied',3,'LEB-11-4618','Truck','Shahmeer Bajwa','0321-3456789',17,TO_DATE('2026-05-13 08:30','YYYY-MM-DD HH24:MI'),NULL,NULL,17,80,NULL);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A004','G10','Block-D Sector G10',60,'S004','Occupied',4,'RWP-7723','Car','Ayesha Khalid','0333-4567890',2,TO_DATE('2026-05-02 07:15','YYYY-MM-DD HH24:MI'),TO_DATE('2026-05-02 09:45','YYYY-MM-DD HH24:MI'),2.50,2,50,125);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A005','Blue','Blue Area F-7',80,'S005','Available',5,'ISB-5541','Van','Bilal Akhtar','0345-5678901',11,TO_DATE('2026-05-11 08:00','YYYY-MM-DD HH24:MI'),TO_DATE('2026-05-11 10:00','YYYY-MM-DD HH24:MI'),2.00,11,60,120);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A006','F10','Block-A F10',45,'S006','Occupied',6,'LHR-9901','Bus','Tariq Mehmood','0301-6789012',3,TO_DATE('2026-05-03 06:00','YYYY-MM-DD HH24:MI'),TO_DATE('2026-05-03 14:00','YYYY-MM-DD HH24:MI'),8.00,3,100,800);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A007','G9','Block-E Sector G9',35,'S007','Occupied',7,'MUL-3312','Car','Sana Riaz','0312-7890123',18,TO_DATE('2026-05-13 09:00','YYYY-MM-DD HH24:MI'),NULL,NULL,18,50,NULL);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A008','I10','Block-F Sector I10',55,'S008','Available',8,'KHI-6654','Truck','Usman Farooq','0322-8901234',12,TO_DATE('2026-05-11 09:15','YYYY-MM-DD HH24:MI'),TO_DATE('2026-05-11 16:45','YYYY-MM-DD HH24:MI'),7.50,12,50,375);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A009','Aabpara','Aabpara Market',25,'S009','Occupied',9,'PES-4478','Bike','Nadia Hussain','0334-9012345',4,TO_DATE('2026-05-04 09:30','YYYY-MM-DD HH24:MI'),TO_DATE('2026-05-04 11:00','YYYY-MM-DD HH24:MI'),1.50,4,30,45);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A010','Melody','Melody Market G-6',20,'S010','Available',10,'FSD-2201','Car','Asad Nawaz','0346-0123456',13,TO_DATE('2026-05-12 07:30','YYYY-MM-DD HH24:MI'),TO_DATE('2026-05-12 12:00','YYYY-MM-DD HH24:MI'),4.50,13,50,225);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A011','PWD','PWD Housing Sector',70,'S011','Occupied',11,'SWL-8831','Van','Rabia Zahoor','0302-1234568',19,TO_DATE('2026-05-13 09:30','YYYY-MM-DD HH24:MI'),NULL,NULL,19,60,NULL);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A012','Bahria','Bahria Town Ph-2',100,'S012','Occupied',12,'AJK-1199','Car','Kashif Iqbal','0313-2345679',5,TO_DATE('2026-05-05 10:00','YYYY-MM-DD HH24:MI'),TO_DATE('2026-05-05 12:30','YYYY-MM-DD HH24:MI'),2.50,5,50,125);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A013','DHA','DHA Phase-1',90,'S013','Available',13,'GTB-7755','Bike','Zara Sheikh','0323-3456780',14,TO_DATE('2026-05-12 10:00','YYYY-MM-DD HH24:MI'),TO_DATE('2026-05-12 11:30','YYYY-MM-DD HH24:MI'),1.50,14,30,45);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A014','H8','Block-B Sector H8',50,'S014','Occupied',14,'SKT-3367','Truck','Imran Qureshi','0335-4567891',6,TO_DATE('2026-05-06 08:45','YYYY-MM-DD HH24:MI'),TO_DATE('2026-05-06 13:15','YYYY-MM-DD HH24:MI'),4.50,6,80,360);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A015','G11','Block-C Sector G11',40,'S015','Occupied',15,'BWP-9920','Car','Mehwish Anwar','0347-5678902',20,TO_DATE('2026-05-13 10:00','YYYY-MM-DD HH24:MI'),NULL,NULL,20,50,NULL);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A016','Koral','Koral Chowk Area',30,'S016','Available',16,'GUJ-5544','Van','Fahad Mirza','0303-6789013',15,TO_DATE('2026-05-13 06:00','YYYY-MM-DD HH24:MI'),TO_DATE('2026-05-13 09:30','YYYY-MM-DD HH24:MI'),3.50,15,60,210);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A017','Tarlai','Tarlai Kalan',25,'S017','Occupied',17,'HYD-2278','Bus','Amina Shahid','0314-7890124',7,TO_DATE('2026-05-07 07:00','YYYY-MM-DD HH24:MI'),TO_DATE('2026-05-07 10:00','YYYY-MM-DD HH24:MI'),3.00,7,100,300);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A018','Faizabad','Faizabad Junction',60,'S018','Occupied',18,'QTA-6612','Car','Zubair Hassan','0324-8901235',21,TO_DATE('2026-05-13 10:15','YYYY-MM-DD HH24:MI'),NULL,NULL,21,100,NULL);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A019','Golra','Golra Mor',35,'S019','Occupied',19,'SHK-4456','Bike','Hira Aslam','0336-9012346',22,TO_DATE('2026-05-13 10:45','YYYY-MM-DD HH24:MI'),NULL,NULL,22,30,NULL);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A020','I14','Block-A Sector I14',45,'S020','Occupied',20,'RYK-1123','Truck','Naveed Cheema','0348-0123457',8,TO_DATE('2026-05-08 11:00','YYYY-MM-DD HH24:MI'),TO_DATE('2026-05-08 15:30','YYYY-MM-DD HH24:MI'),4.50,8,80,360);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A021','H10','Block-D Sector H10',30,'S021','Occupied',21,'DGK-8897','Car','Sidra Malik','0304-1234569',23,TO_DATE('2026-05-13 11:00','YYYY-MM-DD HH24:MI'),NULL,NULL,23,50,NULL);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A022','G13','Block-F Sector G13',55,'S022','Occupied',22,'VHR-3341','Van','Omer Sattar','0315-2345670',9,TO_DATE('2026-05-09 13:00','YYYY-MM-DD HH24:MI'),TO_DATE('2026-05-09 17:00','YYYY-MM-DD HH24:MI'),4.00,9,60,240);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A023','E11','Block-G Sector E11',40,'S023','Occupied',23,'CHK-7765','Car','Farah Ejaz','0325-3456781',24,TO_DATE('2026-05-13 11:30','YYYY-MM-DD HH24:MI'),NULL,NULL,24,80,NULL);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A024','F11','Block-B Sector F11',50,'S024','Occupied',24,'MND-5589','Bike','Waqas Latif','0337-4567892',25,TO_DATE('2026-05-13 12:00','YYYY-MM-DD HH24:MI'),NULL,NULL,25,60,NULL);
INSERT INTO PARKING_UNNORMALIZED VALUES ('A025','I16','Block-H Sector I16',65,'S025','Occupied',25,'TLH-2234','Car','Sobia Yousaf','0349-5678903',10,TO_DATE('2026-05-10 06:30','YYYY-MM-DD HH24:MI'),TO_DATE('2026-05-10 09:00','YYYY-MM-DD HH24:MI'),2.50,10,50,125);

-- AREA
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A001', 'I8',      'Block-A Sector I8',   50);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A002', 'Saddar',  'Block-B Saddar',      40);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A003', 'F9',      'Block-C F9',          30);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A004', 'G10',     'Block-D Sector G10',  60);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A005', 'Blue',    'Blue Area F-7',       80);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A006', 'F10',     'Block-A F10',         45);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A007', 'G9',      'Block-E Sector G9',   35);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A008', 'I10',     'Block-F Sector I10',  55);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A009', 'Aabpara', 'Aabpara Market',      25);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A010', 'Melody',  'Melody Market G-6',   20);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A011', 'PWD',     'PWD Housing Sector',  70);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A012', 'Bahria',  'Bahria Town Ph-2',    100);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A013', 'DHA',     'DHA Phase-1',         90);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A014', 'H8',      'Block-B Sector H8',   50);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A015', 'G11',     'Block-C Sector G11',  40);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A016', 'Koral',   'Koral Chowk Area',    30);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A017', 'Tarlai',  'Tarlai Kalan',        25);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A018', 'Faizabad','Faizabad Junction',   60);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A019', 'Golra',   'Golra Mor',           35);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A020', 'I14',     'Block-A Sector I14',  45);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A021', 'H10',     'Block-D Sector H10',  30);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A022', 'G13',     'Block-F Sector G13',  55);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A023', 'E11',     'Block-G Sector E11',  40);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A024', 'F11',     'Block-B Sector F11',  50);
INSERT INTO AREA (AreaID, AreaName, Address, Capacity) VALUES ('A025', 'I16',     'Block-H Sector I16',  65);

-- VEHICLE
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('1', 'GAK-882',    'Car',   'Hamza Ali', '0300-1234567');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('2', 'LWF-687',    'Bike',  'Shaheer Jawad',    '0311-2345678');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('3', 'LEB-11-4618','Truck', 'Shahmeer Bajwa',   '0321-3456789');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('4', 'RWP-7723',   'Car',   'Ayesha Khalid',    '0333-4567890');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('5', 'ISB-5541',   'Van',   'Bilal Akhtar',     '0345-5678901');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('6', 'LHR-9901',   'Bus',   'Tariq Mehmood',    '0301-6789012');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('7', 'MUL-3312',   'Car',   'Sana Riaz',        '0312-7890123');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('8', 'KHI-6654',   'Truck', 'Usman Farooq',     '0322-8901234');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('9', 'PES-4478',   'Bike',  'Nadia Hussain',    '0334-9012345');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('10', 'FSD-2201',   'Car',   'Asad Nawaz',       '0346-0123456');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('11', 'SWL-8831',   'Van',   'Rabia Zahoor',     '0302-1234568');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('12', 'AJK-1199',   'Car',   'Kashif Iqbal',     '0313-2345679');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('13', 'GTB-7755',   'Bike',  'Zara Sheikh',      '0323-3456780');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('14', 'SKT-3367',   'Truck', 'Imran Qureshi',    '0335-4567891');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('15', 'BWP-9920',   'Car',   'Mehwish Anwar',    '0347-5678902');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('16', 'GUJ-5544',   'Van',   'Fahad Mirza',      '0303-6789013');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('17', 'HYD-2278',   'Bus',   'Amina Shahid',     '0314-7890124');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('18', 'QTA-6612',   'Car',   'Zubair Hassan',    '0324-8901235');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('19', 'SHK-4456',   'Bike',  'Hira Aslam',       '0336-9012346');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('20', 'RYK-1123',   'Truck', 'Naveed Cheema',    '0348-0123457');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('21', 'DGK-8897',   'Car',   'Sidra Malik',      '0304-1234569');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('22', 'VHR-3341',   'Van',   'Omer Sattar',      '0315-2345670');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('23', 'CHK-7765',   'Car',   'Farah Ejaz',       '0325-3456781');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('24', 'MND-5589',   'Bike',  'Waqas Latif',      '0337-4567892');
INSERT INTO VEHICLE (VehicleID, Plate, VType, OwnerName, ContactNo) VALUES ('25', 'TLH-2234',   'Car',   'Sobia Yousaf',     '0349-5678903');

-- SLOT
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S001', 'A001', 'Occupied');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S002', 'A002', 'Occupied');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S003', 'A003', 'Occupied');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S004', 'A004', 'Occupied');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S005', 'A005', 'Available');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S006', 'A006', 'Occupied');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S007', 'A007', 'Occupied');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S008', 'A008', 'Available');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S009', 'A009', 'Occupied');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S010', 'A010', 'Available');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S011', 'A011', 'Occupied');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S012', 'A012', 'Occupied');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S013', 'A013', 'Available');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S014', 'A014', 'Occupied');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S015', 'A015', 'Occupied');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S016', 'A016', 'Available');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S017', 'A017', 'Occupied');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S018', 'A018', 'Occupied');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S019', 'A019', 'Occupied');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S020', 'A020', 'Occupied');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S021', 'A021', 'Occupied');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S022', 'A022', 'Occupied');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S023', 'A023', 'Occupied');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S024', 'A024', 'Occupied');
INSERT INTO SLOT (SlotID, AreaID, SlotStatus) VALUES ('S025', 'A025', 'Occupied');

-- TRACKING
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('11','S001',  '1', TO_DATE('2026-05-01 08:00','YYYY-MM-DD HH24:MI'), TO_DATE('2026-05-01 10:30','YYYY-MM-DD HH24:MI'), 2.50);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('12','S004',  '4', TO_DATE('2026-05-02 07:15','YYYY-MM-DD HH24:MI'), TO_DATE('2026-05-02 09:45','YYYY-MM-DD HH24:MI'), 2.50);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('13','S006',  '6', TO_DATE('2026-05-03 06:00','YYYY-MM-DD HH24:MI'), TO_DATE('2026-05-03 14:00','YYYY-MM-DD HH24:MI'), 8.00);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('14','S009',  '9', TO_DATE('2026-05-04 09:30','YYYY-MM-DD HH24:MI'), TO_DATE('2026-05-04 11:00','YYYY-MM-DD HH24:MI'), 1.50);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('15','S012', '12', TO_DATE('2026-05-05 10:00','YYYY-MM-DD HH24:MI'), TO_DATE('2026-05-05 12:30','YYYY-MM-DD HH24:MI'), 2.50);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('16','S014', '14', TO_DATE('2026-05-06 08:45','YYYY-MM-DD HH24:MI'), TO_DATE('2026-05-06 13:15','YYYY-MM-DD HH24:MI'), 4.50);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('17','S017', '17', TO_DATE('2026-05-07 07:00','YYYY-MM-DD HH24:MI'), TO_DATE('2026-05-07 10:00','YYYY-MM-DD HH24:MI'), 3.00);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('18','S020', '20', TO_DATE('2026-05-08 11:00','YYYY-MM-DD HH24:MI'), TO_DATE('2026-05-08 15:30','YYYY-MM-DD HH24:MI'), 4.50);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('19','S022', '22', TO_DATE('2026-05-09 13:00','YYYY-MM-DD HH24:MI'), TO_DATE('2026-05-09 17:00','YYYY-MM-DD HH24:MI'), 4.00);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('110','S025', '25', TO_DATE('2026-05-10 06:30','YYYY-MM-DD HH24:MI'), TO_DATE('2026-05-10 09:00','YYYY-MM-DD HH24:MI'), 2.50);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('111','S005',  '5', TO_DATE('2026-05-11 08:00','YYYY-MM-DD HH24:MI'), TO_DATE('2026-05-11 10:00','YYYY-MM-DD HH24:MI'), 2.00);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('112','S008',  '8', TO_DATE('2026-05-11 09:15','YYYY-MM-DD HH24:MI'), TO_DATE('2026-05-11 16:45','YYYY-MM-DD HH24:MI'), 7.50);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('113','S010', '10', TO_DATE('2026-05-12 07:30','YYYY-MM-DD HH24:MI'), TO_DATE('2026-05-12 12:00','YYYY-MM-DD HH24:MI'), 4.50);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('114','S013', '13', TO_DATE('2026-05-12 10:00','YYYY-MM-DD HH24:MI'), TO_DATE('2026-05-12 11:30','YYYY-MM-DD HH24:MI'), 1.50);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('115','S016', '16', TO_DATE('2026-05-13 06:00','YYYY-MM-DD HH24:MI'), TO_DATE('2026-05-13 09:30','YYYY-MM-DD HH24:MI'), 3.50);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('116','S002',  '2', TO_DATE('2026-05-13 08:00','YYYY-MM-DD HH24:MI'), NULL, NULL);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('117','S003',  '3', TO_DATE('2026-05-13 08:30','YYYY-MM-DD HH24:MI'), NULL, NULL);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('118','S007',  '7', TO_DATE('2026-05-13 09:00','YYYY-MM-DD HH24:MI'), NULL, NULL);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('119','S011', '11', TO_DATE('2026-05-13 09:30','YYYY-MM-DD HH24:MI'), NULL, NULL);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('120','S015', '15', TO_DATE('2026-05-13 10:00','YYYY-MM-DD HH24:MI'), NULL, NULL);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('121','S018', '18', TO_DATE('2026-05-13 10:15','YYYY-MM-DD HH24:MI'), NULL, NULL);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('122','S019', '19', TO_DATE('2026-05-13 10:45','YYYY-MM-DD HH24:MI'), NULL, NULL);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('123','S021', '21', TO_DATE('2026-05-13 11:00','YYYY-MM-DD HH24:MI'), NULL, NULL);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('124','S023', '23', TO_DATE('2026-05-13 11:30','YYYY-MM-DD HH24:MI'), NULL, NULL);
INSERT INTO TRACKING (TrackingID, SlotID, VehicleID, EntryTime, ExitTime, DurationHrs) VALUES ('125','S024', '24', TO_DATE('2026-05-13 12:00','YYYY-MM-DD HH24:MI'), NULL, NULL);

-- FEE
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (211, 11,  50.00,  125.00);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (212, 12,  50.00,  125.00);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (213, 13, 100.00,  800.00);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (214, 14,  30.00,   45.00);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (215, 15,  50.00,  125.00);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (216, 16,  80.00,  360.00);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (217, 17, 100.00,  300.00);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (218, 18,  80.00,  360.00);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (219, 19,  60.00,  240.00);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (220, 110, 50.00,  125.00);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (221, 111, 60.00,  120.00);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (222, 112, 50.00,  375.00);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (223, 113, 50.00,  225.00);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (224, 114, 30.00,   45.00);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (225, 115, 60.00,  210.00);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (226, 116, 30.00, NULL);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (227, 117, 80.00, NULL);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (228, 118, 50.00, NULL);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (229, 119, 60.00, NULL);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (230, 120, 50.00, NULL);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (231, 121,100.00, NULL);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (232, 122, 30.00, NULL);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (233, 123, 50.00, NULL);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (234, 124, 80.00, NULL);
INSERT INTO FEE (FeeID, TrackingID, HourlyRate, TotalFee) VALUES (235, 125, 60.00, NULL);

COMMIT;

SELECT table_name
FROM user_tables
WHERE table_name IN ('AREA','VEHICLE','SLOT','TRACKING','FEE','PARKING_UNNORMALIZED')
ORDER BY table_name;

SELECT * FROM PARKING_UNNORMALIZED;
SELECT * FROM AREA;
SELECT * FROM VEHICLE;
SELECT * FROM SLOT;
SELECT * FROM TRACKING;
SELECT * FROM FEE;


SELECT VEHICLEID, COUNT(*)
FROM TRACKING
GROUP BY VEHICLEID;


