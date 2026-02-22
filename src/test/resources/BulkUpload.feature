Feature: Bulk Invoice Upload with Smart Validation

  # TC_001: Standard Happy Path (UI Test)
  Scenario: Successful upload of a valid Invoice CSV
    Given the user is on the Local Invoice App
    When the user selects a file "invoices_valid.csv"
    And clicks the "Upload Invoices" button
    Then the system should show success message "Upload Successful!"

  # TC_002: Security Check (UI Test)
  Scenario: Smart Validator should block Forged Invoice IDs
    Given the user is on the Local Invoice App
    When the user selects a file "invoices_fake_id.csv"
    And clicks the "Upload Invoices" button
    Then the system should show error message "Security Alert: Invalid Invoice Pattern Detected"

  # TC_003: Data Integrity (UI Test)
  Scenario: System should detect duplicate IDs in the file
    Given the user is on the Local Invoice App
    When the user selects a file "invoices_duplicate.csv"
    And clicks the "Upload Invoices" button
    Then the system should show error message "Data Error: Duplicate Invoice ID Found"

  # TC_004: File Format Validation (UI Test)
  Scenario: System should reject image files
    Given the user is on the Local Invoice App
    When the user selects a file "image.png"
    And clicks the "Upload Invoices" button
    Then the system should show error message "Invalid File Format"

  # TC_005: Empty File Validation (UI Test)
  Scenario: System should reject empty files
    Given the user is on the Local Invoice App
    When the user selects a file "empty_invoice.csv"
    And clicks the "Upload Invoices" button
    Then the system should show error message "File is empty"

  # TC_006: Missing File Check (UI Test)
  Scenario: System should warn if no file is selected
    Given the user is on the Local Invoice App
    When clicks the "Upload Invoices" button
    Then the system should show error message "Please select a file first"

  # TC_007: BULK LOAD SIMULATION (Backend Test for 250 Files)
  Scenario: Backend should process a bulk batch of 250 files efficiently
    Given the system receives a bulk batch of 250 mixed invoice files
    When the batch is processed by the smart backend
    Then the results should be logged into the Excel report