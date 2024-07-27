import Danger 
let danger = Danger()
let allSourceFiles = danger.git.modifiedFiles + danger.git.createdFiles
message("Starting Danger checks")
message("Completed Danger checks")
let changelogChanged = allSourceFiles.contains("CHANGELOG.md")

if !changelogChanged {
  fail("No CHANGELOG entry added.")
}
