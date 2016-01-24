# Dealing with Null

Fireball does not have the "null" keyword and does not allow null to be assigned to any reference type.
Typically "null" is used to represent missing data for reference types, while the CLI type `Nullable[T]`
is used to represent a value type which can contain missing data.  

Fireball also does not allow variable or value declaration without a value. The assignment can be such
that the variable or value is declared with "missing data" initially.

The type `Option[T]` is the cannonical way of representing "missing data", for both reference types and
value types.

A typical _C#_ variable declaration with missing data might look like this:
````
String str = null;
````
The equivalent, `NullReferenceException` safe version of this declaration in Fireball is:
 ````
 var str = Option[String].Empty
 ````

## No "null" keyword is not enough
There are still at least two possible ways for nulls to creep into Fireball code.
* CLR or other .NET library functions that return "null"
* A thrown exception inside of a variable/value assignment

An example of the first case is the [StreamReader.ReadLine()](https://msdn.microsoft.com/en-us/library/system.io.streamreader.readline%28v=vs.110%29.aspx) method.
It returns either a `String`, or "null" when the end of the stream has been reached. Known cases like this can be handled with `Option`'s companion module _apply()_
method, like so:
````
// The type annotation on "nextLine" below is not required. 
// The correct type will be automatically inferred.
val nextLine : Option[String] = Option(reader.ReadLine())

// Or more compactly...
val nextLine2 = Option(reader ReadLine)
````

The second case is more subtle and requires a bit more analysis. Consider the following _C#_ code:
```csharp
var str = "Hello World";
Func<String> GetString = () =>
{
    // This operation throws an exception!
    throw new Exception("Something went wrong!");
    return "Goodbye World";
};

try
{
    str = GetString();
}
catch(Exception e)
{
    System.Console.WriteLine("Error: " + e.Message);
}

// What is going to happen here?
System.Console.WriteLine("Length of str: " + str.Length);

```

As implicated in the code comments above, the final line of that block will throw a `NullReferenceException`.
This is because the assignment in the `try { ... }` block threw an exception, and that exception
was handled ("caught") in the catch block.

What's worse about this example, and more generally assignments inside of a `try {...}` block, is that using 
Fireball's `Option[T]` type would not have helped one bit in this example. The assignment inside the _try_ would
have still threw, and the catch block would have still caught that exception, leaving the _str_ reference null.

## Handling assignments inside try { ... } statements
There were several approaches considered to handle the aformentioned problem of assignments inside of a `try {...}` block (when there is a corresponding `catch {...}` block):
1. Disallow assignments inside _try_ blocks with _catch_ sections
2. Disallow assignments inside _try_ blocks entirely!
3. Require all variables assigned inside of a _try_ block to also be assigned inside of the _catch_ block
4. Require all variables assigned inside of a _try_ block to be of type `Option[T]`
5. Rewrite all assignments inside of a _try_ block to use some sort of a _safeCall(...)_ macro
6. Require all assignments to use `Option( {assignment expression} )` syntax    

Ultimately, all of these approaches have drawbacks or are not sufficient by themselves to prevent the "null" from being assigned to whichever reference.

**There has not yet been a design decision on which approach(s) will be used to help prevent the "null" reference from appearing inside Fireball code.**