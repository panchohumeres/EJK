### Crear una nueva rama a partir de el contenido de una sóla carpeta
* https://stackoverflow.com/questions/9971332/git-create-a-new-branch-with-only-a-specified-directory-and-its-history-then-pus

git branch subdir_branch HEAD
git filter-branch --subdirectory-filter dir/to/filter -- subdir_branch
git push git://.../new_repo.git subdir_branch:master

### Clonar una sóla rama
* https://stackoverflow.com/questions/4811434/clone-only-one-branch

git clone -b data_dict --single-branch https://github.com/Work/mvp-BI.git

### ELiminar un remoto

https://help.github.com/es/github/using-git/removing-a-remote

### Agregar remotos

https://articles.assembla.com/en/articles/1136998-how-to-add-a-new-remote-to-your-git-repo

## TROUBLESHOOTING:

* **ERROR:**
    git merge data_dict 
fatal: refusing to merge unrelated histories
**Solución:**
https://github.community/t5/How-to-use-Git-and-GitHub/How-to-deal-with-quot-refusing-to-merge-unrelated-histories-quot/td-p/12619#
    git merge --allow-unrelated-histories data_dict