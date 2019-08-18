## Vector library
Allows for vector-like table manipulation.  
Vector values are keyed with *numbers*, in case of uneven sizes larger vector is treated as having the size of smaller one.  
While types of input arguments are asserted, values in the vector table are not checked and invalid vectors can lead to errors.  
None of the methods modify any of the arguments.  
Again, STRING KEYS ARE IGNORED. Keep in mind when using with TTS position vectors and such - only use their numeric part then.

**Access table:** ``Vect``

### Example usage
```lua
myVect = {1, 2, 3}
anotherVect = Vect.Sum(myVect, {2, 2, 2})   -- Result: anotherVect = {3, 4, 5}
anotherVect = Vect.Scale(anotherVect, 0.5)  -- Result: anotherVect = {1.5, 2, 2.5}
```

### Full interface

| Method(args) | Return type | Return description |
| --- | --- | --- |
| ``Sum (Vector, Vector)`` | ``Vector`` | with matching elements summed |
| ``Inverse (Vector)`` | ``Vector`` | with each element inversed (1/val) |
| ``Scale (Vector, Number)`` | ``Vector`` | with all elements multiplied by factor |
| ``ScaleEach (Vector, Vector)`` | ``Vector`` | with all elements multiplied by matching element from 2nd argument |
| ``Length (Vector)`` | ``Number`` | length of a vector only considering its 1st and 3rd element (in-plane-length in TTS) |
| ``RotateRad (Vector, Number)`` | ``Vector`` | rotated by 2nd argument in radians over its second element axis |
| ``Distance (Vector, Vector)`` | ``Number`` | in-plane distance between two Vectors (works like Length method)
| ``Distance (Object, Object)`` | ``Number`` | in-plane distance between two Objects (works like Length method)
| ``Print (Vector, String)`` | ``nil`` | Console output: vector elements, prefixed by string passed as 2nd argument |
| ``DotProd (Vector, Vector)`` | ``Number`` | dot product of two vectors |
| ``Norm (Vector)`` | ``Number`` | Euclidean norm of a vector |
| ``ToUnit (Vector)`` | ``Vector`` | scaled to a norm of 1 |
| ``Angle (Vector, Vector)`` | ``Number`` | angle between vectors in radians |
| ``Compare (Vector, Vector)`` | ``Bool`` | true if vectors of equal size and matching elements equal |
| | |
| ``Sub (Vector, Vector)`` | ``Vector`` | 2nd argument vector subtracted from 1st argument vector |
| ``RotateDeg (Vector, Number)`` | ``Vector`` | same as Rotate() but with 2nd argument in degrees |
| ``AngleDeg (Vector, Vector)`` | ``Number`` | same as Angle() but returning angle in degrees |
| ``Between (Vector, Vector)`` | ``Vector`` | pointing from the 1st argument to the 2nd argument |
| ``Opposite (Vector)`` | ``Vector`` | with all elements multiplied by -1 |
| ``SetLength (Vector, Number)`` | ``Vector`` | scaled to Length() equal to to 2nd argument|
