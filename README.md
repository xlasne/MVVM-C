# MVVM-C (MVVM + Context Mgr)
MVVM-C introduces the exemple presented at Cocoaheads Paris 14 April 2016, with a simple and efficient way to use MVVM in complex OSX application with multiple view controllers and highly dependent data model.

This example implements an OSX Document based application with:

* Document Write / Read
* Programmatic instantiation of View Controllers
* The top view controller set the data model value number1
* The 2 bottom view controllers set the value number2
* The SumProcessor perform background processing, and generate a data model update on end of background processing.
* Top view controller can hide or show the bottom view controllers.

The whole application demonstrates MVVM-C principles described in the Paris 14 April 2016 Cocoaheads session