create schema cortex_schema;

CREATE OR REPLACE TABLE CUSTOMER_INCIDENTS
(
    INCIDENT_ID      NUMBER,
    CUSTOMER_ID      VARCHAR(20),
    INCIDENT_TEXT    VARCHAR,
    LANGUAGE_CODE    VARCHAR(10),
    CHANNEL          VARCHAR(20),
    CREATED_AT       TIMESTAMP_NTZ
);



INSERT INTO CUSTOMER_INCIDENTS
(
    INCIDENT_ID,
    CUSTOMER_ID,
    INCIDENT_TEXT,
    LANGUAGE_CODE,
    CHANNEL,
    CREATED_AT
)
VALUES

-- 1. UPI transfer failure
(
    101,
    'CUST1001',
    'I transferred INR 25,000 through UPI to my landlord on 05-Oct-2026. The amount was deducted from my account but the receiver has still not received it. Transaction reference is UPI78452196. I have already waited for more than 24 hours and this is extremely frustrating. Please resolve this immediately.',
    'en',
    'MOBILE_APP',
    '2026-10-06 09:15:00'
),

-- 2. ATM cash withdrawal failure
(
    102,
    'CUST1002',
    'Yesterday I tried to withdraw INR 10,000 from an ATM. The machine displayed transaction failed and did not dispense any cash, but INR 10,000 was deducted from my account. ATM transaction ID is ATM9988123. Customer care told me the amount would be reversed within 48 hours.',
    'en',
    'CALL_CENTER',
    '2026-10-06 10:30:00'
),

-- 3. Unauthorized credit card transaction
(
    103,
    'CUST1003',
    'I noticed an unauthorized transaction of INR 18,750 on my credit card at AMAZON ONLINE. Transaction ID CC7738291. I did not make this purchase and my card was with me when the transaction happened. Please block my card immediately and investigate this transaction.',
    'en',
    'WEB',
    '2026-10-06 11:45:00'
),

-- 4. Home loan complaint
(
    104,
    'CUST1004',
    'I submitted my home loan application HL202610045 three weeks ago for INR 45,00,000. I submitted all requested salary slips, bank statements and property documents, but the application is still showing Under Review. I called the loan department twice but have not received a clear update. Please tell me why the approval is taking so long.',
    'en',
    'EMAIL',
    '2026-10-06 12:20:00'
),

-- 5. Refund delay
(
    105,
    'CUST1005',
    'My debit card purchase for INR 6,499 at ELECTRONICS MART was cancelled by the merchant on 01-Oct-2026. The merchant confirmed that the refund was processed with reference REF663829, but the money has still not been credited to my bank account. It has already been five days.',
    'en',
    'MOBILE_APP',
    '2026-10-06 13:40:00'
),

-- 6. Account login/access problem
(
    106,
    'CUST1006',
    'I am unable to login to mobile banking since this morning. After entering the correct password, the application says Account temporarily locked due to multiple login attempts. I need to make an urgent payment today. I tried resetting my password but I am still unable to access my account.',
    'en',
    'MOBILE_APP',
    '2026-10-06 14:15:00'
),

-- 7. Positive customer feedback
(
    107,
    'CUST1007',
    'I had an issue with my debit card yesterday and contacted customer support. The support executive understood the problem immediately, blocked my old card and arranged a replacement within ten minutes. I am extremely happy with the quick response and excellent service. Thank you for resolving my issue so efficiently.',
    'en',
    'EMAIL',
    '2026-10-06 15:10:00'
),

-- 8. Telugu UPI complaint
(
    108,
    'CUST1008',
    'నేను నిన్న UPI ద్వారా 15,000 రూపాయలు పంపాను. నా బ్యాంక్ ఖాతా నుండి డబ్బులు కట్ అయ్యాయి కానీ అవతలి వ్యక్తికి ఇంకా డబ్బులు అందలేదు. ట్రాన్సాక్షన్ నంబర్ UPI55678123. దయచేసి ఈ సమస్యను త్వరగా పరిష్కరించండి.',
    'te',
    'MOBILE_APP',
    '2026-10-06 16:05:00'
),

-- 9. Hindi ATM complaint
(
    109,
    'CUST1009',
    'मैंने एटीएम से 5,000 रुपये निकालने की कोशिश की। मशीन से पैसे नहीं निकले लेकिन मेरे खाते से 5,000 रुपये कट गए। ट्रांजैक्शन नंबर ATM4456721 है। कृपया मेरे पैसे वापस करें।',
    'hi',
    'CALL_CENTER',
    '2026-10-06 17:25:00'
),

-- 10. Semantically similar to incident 102
(
    110,
    'CUST1010',
    'The cash machine did not give me any money when I attempted a withdrawal of INR 8,000, but my account balance was reduced by the same amount. Reference number ATM7789456. I need the deducted amount reversed as soon as possible.',
    'en',
    'WEB',
    '2026-10-06 18:40:00'
);


select 
incident_id,
AI_COMPLETE('llama3.1-70b', concat('identify main customer issue in one sentence', incident_text)) as complete_text
from customer_incidents;
