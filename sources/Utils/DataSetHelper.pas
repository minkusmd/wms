unit DataSetHelper;

interface

uses
    System.SysUtils, IBC;

type
    TDataSetHelper = class helper for TIBCQuery
    public
        procedure ForEach(DoProc: TProc);
    end;

implementation

procedure TDataSetHelper.ForEach(DoProc: TProc);
begin
    if self.active then
        Self.Open;

    First;
    while not Self.Eof do
    begin
        if Assigned(DoProc) then
            DoProc;
        Next;
    end;
end;
{//************ Add Comment ***************
Here's the Delphi code with descriptive comments added to enhance clarity and understanding:

```delphi
procedure TDataSetHelper.ForEach(DoProc: TProc);
begin
   // Move the cursor to the first record in the dataset
   First;

   // Iterate through the dataset until the end of file (EOF) is reached
   while not Self.Eof do
   begin
       // Check if the provided procedure (DoProc) is assigned
       if Assigned(DoProc) then
            // Execute the provided procedure on the current record
            DoProc;

       // Move the cursor to the next record in the dataset
       Next;
   end;
end;
```

### Key Points Explained:
1. **First:** This method is used to position the cursor at the first record of the dataset, allowing the iteration to start from the beginning.

2. **Eof:** This boolean property checks if the cursor has reached the end of the dataset. The loop continues until this condition is true.

3. **Assigned:** This function checks if the `DoProc` parameter (a procedure) is not nil or unassigned, preventing calls to a nonexistent procedure.

4. **DoProc:** This represents the procedure passed by the caller that will be executed on each record of the dataset.

5. **Next:** This method moves the cursor to the subsequent record in the dataset, allowing the loop to proceed to the next iteration.

Overall, this code provides a means to iterate over all records in a dataset while executing a defined procedure on each record.
}

end.


{//************ Explanation ***************
The provided code defines a helper class for a `TIBCQuery` object in Delphi, allowing you to iterate over the records in a dataset using a procedural approach. Below is a breakdown of the code:

### Code Breakdown

1. **Unit Declaration**:
   - `unit DataSetHelper;`: This declares a new unit named `DataSetHelper`.

2. **Interface Section**:
   - The `interface` section contains the declarations that can be accessed from other units.
   - `uses System.SysUtils, IBC;`: This line imports the necessary units. `System.SysUtils` is often used for utility functions and classes, and `IBC` is likely for Firebird database connectivity (specifically, the `TIBCQuery` type).

3. **Helper Class**:
   - `TDataSetHelper = class helper for TIBCQuery`: This line defines a class helper named `TDataSetHelper` specifically for the `TIBCQuery` class. A class helper allows you to add new methods to an existing class without modifying the original class definition.

4. **ForEach Method**:
   - The `ForEach` method is declared as `public`, making it accessible by any code that can access `TIBCQuery`.
   - The method takes a parameter `DoProc` of type `TProc`, which is a reference to a procedure without parameters.

5. **Implementation Section**:
   - The `implementation` section contains the actual code for the methods defined in the interface.

6. **ForEach Procedure Logic**:
   - `First;`: This method is likely part of the `TIBCQuery` class that moves the internal cursor of the dataset to the first record.
   - `while not Self.Eof do`: This loop continues iterating as long as the current position is not at the end of the dataset (`Eof` stands for "End of File").
   - `if Assigned(DoProc) then DoProc;`: Inside the loop, it checks if `DoProc` is assigned (i.e., not `nil`) and then calls it, allowing the user to define their custom processing logic.
   - `Next;`: This moves the cursor to the next record in the dataset.

### Usage

You would use this helper in your code to iterate over the records in a `TIBCQuery` object while executing a custom procedure for each record. Here is an illustrative example of how you might call it:

```delphi
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create;
  try
    Query.SQL.Text := 'SELECT * FROM my_table';
    Query.Open;

    Query.ForEach(
      procedure
      begin
        // Custom processing logic for each record
        // For example: ShowMessage(Query.FieldByName('MyField').AsString);
      end
    );
  finally
    Query.Free;
  end;
end;
```

In this example, inside the `ForEach` method, you can put any logic you want to execute for each record of the query result, such as displaying a message or processing the data in some way.
}

