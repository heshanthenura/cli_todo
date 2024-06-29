import os, terminal, strutils

const
  reset = "\e[0m"
  bold = "\e[1m"
  underline = "\e[4m"

  fgBlack = "\e[30m"
  fgRed = "\e[31m"
  fgGreen = "\e[32m"
  fgYellow = "\e[33m"
  fgBlue = "\e[34m"
  fgMagenta = "\e[35m"
  fgCyan = "\e[36m"
  fgWhite = "\e[37m"

  bgBlack = "\e[40m"
  bgRed = "\e[41m"
  bgGreen = "\e[42m"
  bgYellow = "\e[43m"
  bgBlue = "\e[44m"
  bgMagenta = "\e[45m"
  bgCyan = "\e[46m"
  bgWhite = "\e[47m"

var menu: seq[string] = @["view", "add", "quit"]
var menuIndex: int = 0
var printedLines =0;
proc printMenu(menu: seq[string], menuIndex: int) =
  for i in 0..<menu.len:
    if i == menuIndex:
      stdout.write(bgBlue & fgWhite & menu[i] & reset & "\n")
      printedLines+=1
    else:
      stdout.write(menu[i] & "\n")
      printedLines+=1


proc clearLastLines(n: int) =
  for i in 0..<n:
    stdout.write("\e[A\e[2K")  # Move cursor up and clear the line
  flushFile(stdout)

when isMainModule:
  echo bgWhite & fgBlack & " TODO APP " & reset & "\n\n"

  while true:
    printMenu(menu, menuIndex)
    flushFile(stdout)
    let key = getch()
    let lowerCaseKey = key.toLowerAscii() 
    if lowerCaseKey == 's':  # Compare with char literal 's' (not string literal "s")
      menuIndex = (menuIndex + 1) mod menu.len  # Move down the menu
    elif lowerCaseKey == 'w':  # Compare with char literal 'w' (not string literal "w")
      menuIndex = (menuIndex - 1 + menu.len) mod menu.len  # Move up the menu
    elif lowerCaseKey == '\x0D':
      if menuIndex == 2:
        quit(0)
    elif lowerCaseKey == 'q':  # Compare with char literal 'q' (not string literal "q")
      break  # Exit the loop on 'q' key press


    clearLastLines(printedLines)  # Clear the printed lines (menu and the prompt)
    printedLines=0
