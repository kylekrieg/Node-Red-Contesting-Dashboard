# Node Red Contesting Dashboard

A basic multi screen contesting dasbhoard written in Node Red.  Currently it can display stats and contest related info contesting logging software.

## About

This program is written in Node Red and displays a real time dashboard for ham radio contesting events.  Radio, score, contact and lookup UDP broadcast packets are sent from each contesting computer to the Node Red server.  That information is parsed out and displayed in real time for other contesters to follow.  This dashboard is useful in a SO1V, SO2V, SO2R, multi/1, multi/2, multi-multi radio setup.  It allows non-operating operators to keep up with the contest without hovering over an operators shoulders.  This dashboard also allows an operator to stream the dashboard via the internet to engage an on-line audience.  The program is also useful during Field Day where other operators or guests can follow along in the contest progress.

## Supported Loggers
|                    Logger Option                  | Compatiblity  |
| :-------------------:                             | :------------:|
| [N1MM Logger +](https://n1mmwp.hamdocs.com)       | Supported     |
| [TR4W](https://tr4w.net/)                         | Supported     |
| [DXLog](http://dxlog.net/)                        | Spotty        |
| [RumLog](https://dl2rum.de/rumsoft/RUMLog.html)   | Spotty        |
| [N3FJP](https://www.n3fjp.com/)                   | Non-Currently Supported  (Need help implmementing)  |

## Screenshots

Here are some basic screenshots of the different tabs within the dashboard taken March 2022.

[Node Red Dashboard Screenshots](https://photos.app.goo.gl/J67xuLADBU3CMHYh7)

## Install

Follow the [INSTALL.md](/INSTALL.md) located in the files section of this project.

## Questions

Please join the [Node Red for Ham Radio Groups IO discussion](https://groups.io/g/nodered-hamradio) and ask a support question there.
