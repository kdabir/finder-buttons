# MacOS Finder Buttons

![image](https://user-images.githubusercontent.com/735240/64318162-0dec0280-cfd7-11e9-9a20-4c182aa7c811.png)


Buttons to open current finder selection in following apps:

1. Open in Sublime Text

2. Open in iTerm

3. Open in SourceTree

4. Open in IDEA (IntelliJ IDEA)



#### Installing

Git clone / Download the repo and command+drag the icons to Finder Buttons area:

![install](https://user-images.githubusercontent.com/735240/36919049-f5c33b0e-1e81-11e8-9c70-424d2e9ff753.gif)

#### Using
![using](https://user-images.githubusercontent.com/735240/36919050-f73cb0d2-1e81-11e8-80d0-6fc27ddfa38e.gif)


#### Uninstalling
![uninstall](https://user-images.githubusercontent.com/735240/36919048-f3b2a232-1e81-11e8-99a7-09641a96e6ad.gif)




## Building Locally

Add to `.git/config`

```
[diff "scpt"]
  textconv = osadecompile
  binary=true
```

```
$ make all
```