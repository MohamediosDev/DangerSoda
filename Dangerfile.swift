import Danger 
import Foundation

let danger = Danger()
let allSourceFiles = danger.git.modifiedFiles + danger.git.createdFiles
message("Starting Danger checks")
message("Completed Danger checks")
let changelogChanged = allSourceFiles.contains("CHANGELOG.md")

if !changelogChanged {
  fail("No CHANGELOG entry added.")
}
let hasChangelog = danger.git.modifiedFiles.contains("changelog.md")
let isTrivial = ((danger.github.pullRequest.body ?? "") + danger.github.pullRequest.title).contains("#trivial")

let editedFiles = danger.git.modifiedFiles + danger.git.createdFiles
let swiftFilesWithCopyright = editedFiles.filter {
    $0.contains("Copyright") && ($0.fileType == .swift  || $0.fileType == .m)
}
for file in swiftFilesWithCopyright {
    fail(message: "Please remove this copyright header", file: file, line: 0)
}

if (!hasChangelog && !isTrivial) {
    warn("Please add a changelog entry for your changes.")
}

message("You have added 2 more modules to the app")

//  Adds a warning to the table
warn("You have not included a CHANGELOG entry.")

// Declares a blocking
fail("ESLint has failed with \(fails) fails.")
