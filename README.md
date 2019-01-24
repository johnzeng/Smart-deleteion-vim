Smart-deletion-vim

# feature

Allow you to delete to '_' in 'ABC_DEF_HIJ' style word or upper case in camel case style word.

## example 1
```
HELLO_WORLD_VIM|
```
Your course is on '|' position. Now type <M-w> (the default key binding for this plugin), you will get

```
HELLO_WORLD_|
```

Type <M-w> again, you will get
```
HELLO_WORLD|
```

## example 2

```
thisIsHelloWorld|
```
Your course is on '|' position. Now type <M-w> (the default key binding for this plugin), you will get
```
thisIsHello|
```

Type <M-w> again, you will get
```
thisIs|
```

#config

##keybinding

let g:smart_delete_key_map='<M-w>'

this key will be mapped to trigger this script

**make sure your key binding is legal in vim insert mode, some key bindings might be ignore by vim ....**


