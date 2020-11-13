//
//  QuizBank.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 10.10.2020.
//

import Foundation
import RealmSwift

struct QuizBank {
    
    let icons: [String: String] = [
        K.quizTitles.basics : K.basicsIcon,
        K.quizTitles.undoingChanges : K.undoIcon,
        K.quizTitles.rewritingHistory : K.historyIcon,
        K.quizTitles.branches : K.branchesIcon,
        K.quizTitles.remoteRepos : K.reposIcon,
        K.quizTitles.starred : K.bookmark
    ]
    
    let quizDictionary: [String: [Question]] = [
        
        K.quizTitles.basics: [
            Question(q: "Create empty Git repo in specified directory <directory>. Run with no arguments to initialize the current directory as a git repository.", a: "init", a2: "<directory>"),
            Question(q: "Clone repo located at <repo> onto local machine. Original repo can be located on the local filesystem or on a remote machine via HTTP or SSH.", a: "clone", a2: "<repo>"),
            Question(q: "Define author name to be used for all commits in current repo. Devs commonly use --global flag to set config options for current user.", a: "config user.name", a2: "<name>"),
            Question(q: "Stage all changes in <directory> for the next commit. Replace <directory> with a <file> to change a specific file.", a: "add <directory>", a2: "<directory>"),
            Question(q: "Commit the staged snapshot, but instead of launching a text editor, use <message> as the commit message.", a: "commit -m", a2: "\"<message>\""),
            Question(q: "List which files are staged, unstaged, and untracked.", a: "status", a2: ""),
            Question(q: "Display the entire commit history using the default format. For customization see additional options.", a: "log", a2: ""),
            Question(q: "Show unstaged changes between your index and working directory.", a: "diff", a2: "")
        ],
        
        K.quizTitles.undoingChanges: [
            Question(q: "Create new commit that undoes all of the changes made in <commit>, then apply it to the current branch.", a: "revert", a2: "<commit>"),
            Question(q: "Remove <file> from the staging area, but leave the working directory unchanged. This unstages a file without overwriting any changes.", a: "reset", a2: "<file>"),
            Question(q: "Remove <file> from the staging area, but leave the working directory unchanged. This unstages a file without overwriting any changes.", a: "clean", a2: "-n")
        ],
        
        K.quizTitles.rewritingHistory: [
            Question(q: "Replace the last commit with the staged changes and last commit combined. Use with nothing staged to edit the last commit’s message.", a: "commit", a2: "--amend"),
            Question(q: "Rebase the current branch onto <base>. <base> can be a commit ID, branch name, a tag, or a relative reference to HEAD.", a: "rebase", a2: "<base>"),
            Question(q: "Show a log of changes to the local repository’s HEAD. Add --relative-date flag to show date info or --all to show all refs", a: "reflog", a2: "")
        ],
        
        K.quizTitles.branches: [
            Question(q: "List all of the branches in your repo. Add a <branch> argument to create a new branch with the name <branch>.", a: "branch", a2: ""),
            Question(q: "Create and check out a new branch named <branch>. Drop the -b flag to checkout an existing branch.", a: "checkout -b", a2: "<branch>"),
            Question(q: "Merge <branch> into the current branch.", a: "merge", a2: "<branch>")
        ],
        
        K.quizTitles.remoteRepos: [
            Question(q: "List all of the branches in your repo. Add a <branch> argument to create a new branch with the name <branch>.", a: "branch", a2: ""),
            Question(q: "Create and check out a new branch named <branch>. Drop the -b flag to checkout an existing branch.", a: "checkout -b", a2: "<branch>"),
            Question(q: "Merge <branch> into the current branch.", a: "merge", a2: "<branch>")
        ],
        
        K.quizTitles.starred: []
    ]

}

