# 魔改counsel-rg，基于projectile搜索

把counsel-rg函数复制一份，改名cpr-find

```
(defun cpr-find (&optional initial-input)
```

基于projectile找到project-root

```
(project-root (projectile-acquire-root))
```

同步删除或者修改下面的内容
