# Instructions for Contributors and Maintainers

Here's a checklist for Contributors and Maintainers, using [Github workflow](https://guides.github.com/introduction/flow/).
The examples all assume you've [added a github ssh key](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account).

<!-- install markdown-toc: `npm install -g markdown-toc` -->
<!-- run `markdown-toc -i maintainer.md` to update this ToC -->

<!-- toc -->

- [Instructions for Contributors and Maintainers](#instructions-for-contributors-and-maintainers)
  - [Contributors and Maintainers Defined](#contributors-and-maintainers-defined)
  - [Fork the repo](#fork-the-repo)
  - [Add a ref to the upstream repo](#add-a-ref-to-the-upstream-repo)
  - [Make a feature branch](#make-a-feature-branch)
  - [Make your changes](#make-your-changes)
  - [Commit your changes and push to your repo](#commit-your-changes-and-push-to-your-repo)
  - [Submit a Pull Request](#submit-a-pull-request)
  - [Maintainer Only: Review and Merge Pull Request](#maintainer-only-review-and-merge-pull-request)

<!-- tocstop -->

## Contributors and Maintainers Defined

Anybody can be a *Contributor*. Follow the next steps to fork the repo, make a feature branch and submit a pull request (PR).

*Maintainers* have permissions to review and merge PRs into the master branch and to publish to the release branch.

## Fork the repo

If you are new to maintaining the docs, perform this one-time task:

Fork your own copy of the repo. In the examples below, I call it `my-repo`.

Go to https://github.com/kylekrieg/Node-Red-Contesting-Dashboard and click Fork.

Once you've forked it, you can clone it locally to your desktop, following the instructions provided.

```text
$ git clone git@github.com:myname/Node-Red-Contesting-Dashboard.git my-repo
$ cd my-repo
```

Your clone of the repo will have the default remote name of `origin`.

```text
$ git remote -v
origin	git@github.com:myname/examtools-docs.git (fetch)
origin	git@github.com:myname/examtools-docs.git (push)
```

## Add a ref to the upstream repo

Add a reference to upstream so you can keep your fork in sync.

```text
$ git remote add upstream git@github.com:kylekrieg/Node-Red-Contesting-Dashboard.git 
$ git remote -v
origin	git@github.com:myname/Node-Red-Contesting-Dashboard.git  (fetch)
origin	git@github.com:myname/Node-Red-Contesting-Dashboard.git  (push)
upstream	git@github.com:kylekrieg/Node-Red-Contesting-Dashboard.git  (fetch)
upstream	git@github.com:kylekrieg/Node-Red-Contesting-Dashboard.git  (push)
```

Any time you want to get up-to-date with the latest changes, `git pull upstream master`:

```text
$ git checkout master
$ git pull upstream master
remote: Enumerating objects: 1, done.
remote: Counting objects: 100% (1/1), done.
remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (1/1), done.
From github.com:kylekrieg/Node-Red-Contesting-Dashboard
 * branch            master     -> FETCH_HEAD
   03a0672..fca28f5  master     -> upstream/master
Updating 03a0672..fca28f5
Fast-forward
 flow.json | 2 --
 1 file changed, 2 deletions(-)
```

To keep your fork of the repo current, you can push to it (note that the first time you use this shortcut flavor
of `git push` you'll be prompted to do a longer command: `git push --set-upstream origin master`.
From then on just `git push` pushes to your repo).

```text
$ git push
Total 0 (delta 0), reused 0 (delta 0)
To github.com:myname/Node-Red-Contesting-Dashboard.git
   03a0672..fca28f5  master -> master
```

## Make a feature branch

Now that your fork is current with the master branch, make a new feature branch to hold your changes.

```text
$ git checkout -b my_feature
Switched to a new branch 'my_feature'
```

## Make your changes

Make your changes using Node-Red Editor.

## Commit your changes and push to your repo

```text
$ git status
On branch my_feature
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   flow.json

no changes added to commit (use "git add" and/or "git commit -a")
$ git add _index.md
$ git commit -m 'a useful short description here'
[my_feature 7701f9c] a useful short description here
 1 file changed, 37 insertions(+), 34 deletions(-)
$ git push
fatal: The current branch my_feature has no upstream branch.
To push the current branch and set the remote as upstream, use

    git push --set-upstream origin my_feature
$ git push --set-upstream origin my_feature
Enumerating objects: 13, done.
Counting objects: 100% (13/13), done.
Delta compression using up to 8 threads
Compressing objects: 100% (6/6), done.
Writing objects: 100% (7/7), 1.82 KiB | 1.82 MiB/s, done.
Total 7 (delta 3), reused 0 (delta 0)
remote: Resolving deltas: 100% (3/3), completed with 3 local objects.
To github.com:myname/Node-Red-Contesting-Dashboard.git 
   700e65d..7701f9c  my_feature -> my_feature
Enumerating objects: 11, done.
Counting objects: 100% (11/11), done.
Delta compression using up to 8 threads
Compressing objects: 100% (6/6), done.
Writing objects: 100% (6/6), 1.30 KiB | 1.30 MiB/s, done.
Total 6 (delta 2), reused 0 (delta 0)
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
remote:
remote: Create a pull request for 'my_feature' on GitHub by visiting:
remote:      https://github.com/myname/Node-Red-Contesting-Dashboard/pull/new/my_feature
remote:
To github.com:myname/Node-Red-Contesting-Dashboard.git 
 * [new branch]      my_feature -> my_feature
Branch 'my_feature' set up to track remote branch 'my_feature' from 'origin'.
```

## Submit a Pull Request

Now go to the above URL in your browser and you can submit a PR.

You can now create a Pull Request (PR) which submits your edit to the main project:

At this point, if you are happy with your changes, the ball is in the court of the Node-Red-Contesting-Dashboard maintainers. They'll be notified of the PR and will either merge and deploy it or ask you for some further edits.

In the latter case, or if you discover that you didn't edit it quite right and need to tweak your changes,
you can edit some more and submit another commit on the same branch.

## Maintainer Only: Review and Merge Pull Request

As a maintainer you can review the PR, request changes, approve, etc. and then merge it to master.
