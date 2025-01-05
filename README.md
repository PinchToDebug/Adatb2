<h1 align="center">Databases 2 Assignment<br>Pet Shelter</h1>

![Database Schema](https://github.com/user-attachments/assets/4a7f095a-0c5c-4a1f-be34-695df5e33769)



## Overview
This project is a **Pet Shelter Management System**, it includes functionality for managing pets, adopters, medical history, and adoption requests, implemented using Oracle PL/SQL. <br>

The project includes:
- **Tables** to store data related to pets, adopters, medical records, treatments, and adoption requests and logs.
- **Procedures** for adding pets, adopters, adding medical records for pets, surgeries, vaccines, managing adoption requests, logging errors.
- **Functions** for checking pet availability, adoption request status, adopter contact information.
- ~~**Views** for pet details, availibility, pending adoption requests and statistics, medical history and statistics.~~
- **Triggers** to enforce business rules.
- **Error handling** and logging pet table changes.  


> [!IMPORTANT]  <p name="important"></p> 
>The file names are in the order in which they should be executed, including the test files.<br>
>After executing [01_setup_user.sql](https://github.com/PinchToDebug/Adatb2/blob/main/01_setup_user.sql) make sure to log in as **@pet_shelter** with the password: **"12345678"**.

---
### [Tables](https://github.com/PinchToDebug/Adatb2/blob/main/02_init_tables.sql)
   - `pet` stores pet details.
   - `adoption_request` stores adoption requests.
   - `adopter` Stores adopter details.
   - `medical_history` stores medical history records for pets.
   - `vaccine` stores vaccine details.
   - `surgery` stores surgery details.
   - `veterinarian` stores veterinarian details.
   - `pet_log` stores changes to pets in `pets` table.
   - `log` stores occured errors.
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
- [`id_triggers`](https://github.com/PinchToDebug/Adatb2/blob/main/15_id_triggers.sql) Increments ID-s.
---
### [Tests for procedures and functions](https://github.com/PinchToDebug/Adatb2/tree/main/tests)

