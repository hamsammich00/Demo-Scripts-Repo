#define my variables
$script:Output = ""

#this is the function creating the menu
Function Show-menu {
    Clear-host
    Write-host "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
    Write-Host "*-*-*-*-*-*-Menu*-*-*-*-*-*-*-*"
    Write-Host "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
    Write-host ""
    Write-host "Option 1: Test"
    Write-Host "Option 2: Clear output"
    Write-Host "Option 3: Exit"
    Write-host ""
    Write-host "Output: $script:Output"
    Write-host ""
}

#this allows for you to do inputs
function Process-Menu {

    param (
       [int]$choice
)

     switch ($choice) {
        1 {
        $script:Output = "test"
        }

        2 {
        $script:Output = ""
        }

        3 {
        Exit
        }

        }}
 
 #do loop forever with a catch to tell users bad input but does not stop running
do {
    Show-Menu
    $userChoice = Read-Host "Enter a valid option"

	try
		{
		Process-Menu -choice $userChoice}

	catch
		{
        $script:Output = "Numbers only!!!"}

} while ($true)
