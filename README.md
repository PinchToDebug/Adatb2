<h1 align="center">Databases 2 Assignment<br>Pet Shelter</h1>
<p align="center">
  <a href="#"><img src="https://img.shields.io/github/last-commit/pinchtodebug/adatb2" ></a>
  <a href="#"><img src="https://img.shields.io/github/repo-size/pinchtodebug/adatb2"></a>
</p>

![Database Schema](https://github.com/user-attachments/assets/c2720435-684b-4437-95fb-6d4b1c07c977)






## Overview
This project is a **Pet Shelter Management System**, it includes functionality for managing pets, adopters, medical history, and adoption requests, implemented using Oracle PL/SQL.

The project includes:
- **Tables** to store data related to pets, adopters, medical records, treatments, and adoption requests and logs.
- **Procedures** for adding pets, adopters, adding medical records for pets, surgeries, vaccines, managing adoption requests, logging errors.
- **Functions** for checking pet availability, adoption request status, adopter contact information.
- **Views** for pet details, availibility, pending adoption requests and statistics, medical history and statistics.
- **Triggers** to enforce business rules.
- **Error handling** and logging pet table changes.
---
### [Tables](https://github.com/PinchToDebug/Adatb2/blob/main/02_init_tables.sql)
   - `pets` stores pet details.
   - `adoption_requests` stores adoption requests.
   - `adopters` Stores adopter details.
   - `medical_history` stores medical history records for pets.
   - `vaccines` stores vaccine details.
   - `surgeries` stores surgery details.
   - `veterinarians` stores veterinarian details.
   - `pet_log` stores changes to pets in `pets` table.
   - `log` stores occured errors.
---
### [Views](https://github.com/PinchToDebug/Adatb2/blob/main/04_vw_views.s]ql)
   - `vw_pets` View of the `pets` table.
   - `vw_pending_adoption_requests` View for pending adoption requests.
   - `vw_pets_available` View for pets that are available for adoption.
   - `vw_adoption_stats` Statistical view summary of requests grouped by their status and overall count.
   - `vw_pets_medical_history ` View of medical history including the veterinarian.
   - `vw_pets_medical_history_stats ` Trimmed view for `medical_history` with the pet's name.
---
### [adoption_pck package](https://github.com/PinchToDebug/Adatb2/blob/main/06_pkg_adoption_package.pkg)
This package contains procedures and functions for managing adoption-related operations.

- **Procedures**:
  - `submit_request`: Submits an adoption request.
  - `add_adopter`: Adds a new adopter.
  - `manage_adoption_request`: Manages adoption requests (Approve/Reject).
  - `add_pet`: Adds a new pet.

- **Functions**:
  - `fn_is_pet_available`: Returns 'Yes' or 'No' depending on whether the pet is available for adoption based on `pet_id`.
  - `fn_get_adopter_info`: Returns information about a specific adopter based on `adopter_id` ("name: | email: | phone: ").
  - `fn_get_request_status`: Returns the status of an adoption request based on `request_id`.
---
### [pkg_log package](https://github.com/PinchToDebug/Adatb2/blob/main/05_pkg_log.pkg)
This package contains procedures for logging errors in the system.

- **Procedures**:
  - `log_error`: Logs an error message into the `log` table. If no message is provided, the procedure logs the SQL error message (`SQLERRM`). The log entry includes:

    - `log_id` Generated from `seq_log_id.nextval`.
    - `log_time` The current timestamp (`systimestamp`).
    - `severity` Always set to `'ERROR'`.
    - `sql_code` The SQL error code (`SQLCODE`).
    - `message` The error message (either from `p_message` or `SQLERRM`).
    - `api` The API name passed in `p_api`.
    - `backtrace` The backtrace of the error.
---
### Procedures
- [`add_vaccine`](https://github.com/PinchToDebug/Adatb2/blob/main/11_add_vaccine.prc) Adds a new vaccine to the `vaccines` table.
- [`add_surgery`](https://github.com/PinchToDebug/Adatb2/blob/main/12_add_surgery.prc) Adds a new surgery to the `surgeries` table.
- [`add_medical_record`](https://github.com/PinchToDebug/Adatb2/blob/main/14_add_medical_record.prc) Adds a medical record to the `medical_history` table.
- [`add_veterinarian`](https://github.com/PinchToDebug/Adatb2/blob/main/14_add_veterinarian.prc) Adds a veterinarian to the `veterinarians` table.
---
### Triggers
- [`trg_update_pet_status`](https://github.com/PinchToDebug/Adatb2/blob/main/07_tr_update_pet_status.trg) Updates the pet's status to 'Pending' in the `pets` table after an adoption request is inserted.
- [`trg_log_pet_changes`](https://github.com/PinchToDebug/Adatb2/blob/main/08_tr_log_pet_changes.trg) Logs changes to the `pets` table (INSERT, UPDATE, DELETE) into the `pet_log` table.
- [`trg_update_pet_on_reject`](https://github.com/PinchToDebug/Adatb2/blob/main/08_tr_update_pet_status_on_reject.trg) Updates a pet's status to 'Available' in the `pets` table if an adoption request is updated to 'Rejected'.
- [`trg_prevent_pending_adoption`](https://github.com/PinchToDebug/Adatb2/blob/main/10_tr_prevent_pending_adoption.trg) Prevents a new adoption request from being inserted if there is already a pending request for the same pet.
- [`trg_validate_treatment_id`](https://github.com/PinchToDebug/Adatb2/blob/main/15_tr_treatment_id_check.trg) Validates the `treatment_id` in the `medical_history` table to ensure it exists in either the `vaccines` or `surgeries` tables before an insert or update.
- [`trg_validate_veterinarian_id`](https://github.com/PinchToDebug/Adatb2/blob/main/16_tr_valid_vet_id.trg) Ensures the `veterinarian_id` in the `medical_history` table exists in the `veterinarians` table before an insert or update.
- [`trg_validate_treatment_id`](https://github.com/PinchToDebug/Adatb2/blob/main/17_tr_valid_treatment_id.trg) Validates the `treatment_id` in the `medical_history` table based on `treatment_type`. Ensures that for 'SURGERY' types, the `treatment_id` exists in the `surgeries` table, and for 'VACCINE' types, it exists in the `vaccines` table. Logs errors if validation fails.


