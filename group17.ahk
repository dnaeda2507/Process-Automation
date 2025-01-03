#SingleInstance Force

; 1. Launch the Application
Run("CSE303Keygen.exe")
WinWaitActive("CSE303Keygen")  ; Wait for the application to open


; 2. Define the buttonControls Map
buttonControls := Map(
    "0", "WindowsForms10.BUTTON.app.0.141b42a_r8_ad13",
    "1", "WindowsForms10.BUTTON.app.0.141b42a_r8_ad112",
    "2", "WindowsForms10.BUTTON.app.0.141b42a_r8_ad111",
    "3", "WindowsForms10.BUTTON.app.0.141b42a_r8_ad110",
    "4", "WindowsForms10.BUTTON.app.0.141b42a_r8_ad19",
    "5", "WindowsForms10.BUTTON.app.0.141b42a_r8_ad18",
    "6", "WindowsForms10.BUTTON.app.0.141b42a_r8_ad17",
    "7", "WindowsForms10.BUTTON.app.0.141b42a_r8_ad16",
    "8", "WindowsForms10.BUTTON.app.0.141b42a_r8_ad15",
    "9", "WindowsForms10.BUTTON.app.0.141b42a_r8_ad14"
)

generateButton := "WindowsForms10.BUTTON.app.0.141b42a_r8_ad12"
clearDataButton :="WindowsForms10.BUTTON.app.0.141b42a_r8_ad11"
keyEdit := "WindowsForms10.EDIT.app.0.141b42a_r8_ad11"


if !FileExist("serials.txt") {
   
     ; Close the running application
    ProcessClose("CSE303Keygen.exe")  ; Enter the correct application name

     ; Terminate the script
    ExitApp
}

If (FileExist("out-group17.txt")) {
    FileDelete("out-group17.txt")  ; Delete the file
}

serials := StrSplit(FileRead("serials.txt"), "`n")

For serial in serials {
    serial := Trim(serial) ; Clean leading/trailing spaces in the serial
    If (serial = "") {
        Continue  ; Skip if there is an empty line
    }

         serialCleaned := RegExReplace(serial, "[^0-9]") ; Retain only numbers
         If (serialCleaned = "") {
            Continue  ; Skip if the serial is empty
        }
  
       

    ; Split the serial and press the button for each digit
    For i, digit in StrSplit(serialCleaned) {
        
   
        ; Check if it is a valid digit
        If (buttonControls[digit] = "") {  ; If there is no key
            
            Continue
        }
        ; Press the corresponding digit
        ControlClick(buttonControls[digit], "CSE303Keygen")
        Sleep(900)  ; Wait for a short period
    }
    
    If (StrLen(serialCleaned) <= 6) {
    ; Click the Generate button
    ControlClick(generateButton, "CSE303Keygen")
    Sleep(500)  ; Wait for the Generate operation
   

     
     If (StrLen(serialCleaned) < 6) {
          ; Click the OK button and wait for the dialog box
        WinWaitActive("ahk_class #32770")  ; Wait for the window with the OK button to open
        
        Sleep(3000)  ; Wait for 3 seconds to view the content

        ControlClick("Button1", "ahk_class #32770") ; The ClassNN value of the OK button
        Sleep(1000)  ; Wait for the operation

          ; Manually close if the window does not close
    If WinExist("ahk_class #32770") {
        WinClose("ahk_class #32770")
        Sleep(1000)  ; Wait for the closing process
    }
        
        ; Press the ClearData button
        ControlClick(clearDataButton, "CSE303Keygen")
        Sleep(500)  ; Wait for the clearing process
        Continue
    }
     }
        ; Read the KEY result
       result := ControlGetText(keyEdit, "CSE303Keygen")  ; Read the key field
    
    ; Append the result to the file (only valid results)
If (result != "") {
    FileAppend(result "`n", "out-group17.txt")
}
    
    ControlClick(clearDataButton, "CSE303Keygen")  ; Press the ClearData button
    Sleep(500)  ; Wait for the clearing process
}

; 5. Close the Application
ProcessClose("CSE303Keygen.exe")
