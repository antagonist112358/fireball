Multiple Dispatch
=================

 

Implementation Status
---------------------

-   Class Level: **Not Started**

-   Module Level: **Not Started**

-   Extension Methods: **Not Started**

 

Description
-----------

Multiple dispatch is the process of *dynamically dispatching* method or function
calls based on the *runtime *type of one or more of that method or functions
arguments.

 

Fireball supports multiple dispatch (or “Multi-methods”) through the generation
of a compile-time dispatcher method, which matches the runtime type of the
dispatch parameters.

 

The “dispatch parameters” are chosen based on whichever parameters that vary
between overloads of the same method. For example, for the following two methods
(assuming class *B* derives from class *A*):

`def Process(input: A, context: Context) : Output`

`def Process(input: B, context: Context) : Output`

the “dispatch parameters” are simply *input*, as it is the only varying
parameter between the two overloads.

 

The usage of multiple dispatch depends on whether there *could be* a
single-dispatch ambiguity as to the correct overload to use in a particular
case.

 

Multiple dispatch is supported in the following cases:

-   A class which overloads a method

-   A module which overloads a function

-   Methods defined in extension classes

 

Syntax
------

### Methods defined in a marked class

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class SomeClass {
  def DoSomething(p1: IEnumerable) : Unit { ... }
  def DoSomething(p1: List[_]) : Unit { ... }
}

// This is also allowed
[DynamicDispatch]
class AnotherClass extends SomeClass {
  def DoSomething(p1: Array[_]) : Unit { ... }
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

### Methods defined in a module

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
module SomeName {
  def PrettyPrint (p1: BaseType) : String {
    ...
  }

  def PrettyPrint (p1: ChildType) : String {
    ...
  }
}

// Usage
SomeName PrettyPrint instance
// or
SomeName.PrettyPrint(instance)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

### Methods defined in an extension class

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
module SomeName {
  implicit class BaseExtensions(instance: BaseType) {
    def PrettyPrint : String { ... }
  }

  implicit class ChildExtensions(instance: ChildType) {
    def PrettyPrint : String { ... }
  }
}

// Usage
instance PrettyPrint
// or
instance.PrettyPrint
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

### Usage Rules

-   The creation of a runtime (dynamic) dispatcher is triggered by overloaded
    methods of the same name within a module or by the discovery of overloaded
    extension methods

-   The return type of each of the overloaded methods must be the same

-   Method overloads declared in a class which is equipped with multiple
    dispatch **cannot be virtual** (hence cannot be abstract, either)

-   If an extension method overloads an existing class method, the method call
    is dynamically dispatched

 

### Implementation Notes

-   The dispatcher method is created inside of any applicable class(es) or
    module(s)

-   The dispatcher method for extension methods is generated at the *call site*
    of that extension method

 

### CLR Compatibility

-   Other CLR languages attempting to utilize multi-methods defined within a
    module **will work** as expected

-   Other CLR languages attempting to utilize multi-methods defined within a
    marked class **will work** as expected

-   Other CLR languages attempting to utilize multi-methods defined within
    various extension classes **will not work** as expected (since this relies
    on a compile-time generated dispatch method, created at the call site)
