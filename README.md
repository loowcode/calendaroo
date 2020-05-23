# Calendaroo
A Fancy Flutter Calendar

![Banner](https://github.com/jacopo1395/calendaroo/blob/master/android/app/src/main/res/drawable/banner_calendaroo.png?raw=true)

# Install
1. Install [Flutter](https://flutter.dev/docs/get-started/install)
2. In a terminal run `git clone https://github.com/jacopo1395/calendaroo.git`
3. Import in yout IDE

# Run
1. In a terminal run `flutter pub get`
2. Start an Android Emulator or connect an Android Device
3. Run Calendaroo using one of the classes in `/lib/environments/` directory of this repository as main

# Workflow
<img src="https://nvie.com/img/git-model@2x.png" alt="gitflow" width="500"/>

*NB: from develop branch can start also a `fix/<branch-name>` and from release branch can start a `bugfix/<branch-name>`*

## Create Issue
1. Select a **type label** (feture, fix, bugfix, hotfix), a priority label, the milestone and the project
2. Select the **assignee** *(Do this after the selection of a type label: **a github action creates for you an associated branch**)*
3. In a terminal run `git fetch` to update the list of branch

### BranchName Convention
- from develop (default branch): `feature/<issue-number>-<issue-name>` `fix/<issue-number>-<issue-name>`
- from release: `bugfix/<issue-number>-<issue-name>`
- from master: `hotfix/<issue-number>-<issue-name>`

## Pull Request
1. When you create a pull request **include in the message a [keyword](https://help.github.com/en/enterprise/2.16/user/github/managing-your-work-on-github/closing-issues-using-keywords#about-issue-references)** (ex: `Close #1` this comment automitally closes the issue when you merge the PR). Select a reviewer.
2. When the reviewer approves your PR, merge it *(I suggest you to use **squash and delete branch** to remove useless branch)*

# Credits
Thanks to [Vladimir Gubanov](https://dribbble.com/Vladimir_Gubanov) for inspirations

# Contributors
Made with ❤ by Jacopo Carlini, Durante Pellegrino, Giovanna Flore
