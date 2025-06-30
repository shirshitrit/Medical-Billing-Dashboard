SELECT
  bpi.id AS payment_id,
  bpi.bill_id,
  bpi.billed,
  bpi.paid AS paid_amount,
  bpi.balance AS balance_amount,
  bpi.insurance AS insurance_paid,

  b.created AS bill_created,
  b.updated AS bill_updated,
  
  bp.payment_date,

  i.id AS insurance_id,
  i.name AS insurance_name,
  i.state AS insurance_state,
 
  d.id AS doctor_id,
  CONCAT(d.first_name, ' ', d.last_name) AS doctor_full_name,

  ds.name AS doctor_specialty,

  pa.address AS practice_address,
  pa.state AS practice_state,
  pa.zip AS practice_zip,
  pa.facility AS practice_facility,

  bs.name AS bill_status

FROM integrated.bill_payment_info bpi 
JOIN integrated.Bill b ON bpi.bill_id = b.id
JOIN integrated.BillPayment bp ON b.id = bp.bill_id
JOIN integrated.Insurance i ON bp.insurance_id = i.id
JOIN integrated.PracticingDoctor d ON b.doctor_id = d.id
JOIN integrated.DoctorSpeciality ds ON d.speciality_id = ds.id
JOIN integrated.PracticeAddress pa ON b.place_id = pa.id
JOIN integrated.BillStatus bs ON b.bill_status_id = bs.id

WHERE 
  bpi.deleted IS NULL
  AND b.deleted IS NULL
  AND bp.deleted IS NULL
  AND i.deleted IS NULL
  AND pa.deleted IS NULL
  AND d.deleted_at IS NULL
  AND ds.deleted_at IS NULL
  AND bs.deleted IS NULL;
