## Style Guidelines
- Use tabs
- 160 char line limit for code files
- 120 char line limit for header files
- C99
- `namespace_lowercase` for functions, and global variables, types, structs, unions, and enum names
- `NAMESPACE_UPPERCASE` for macros and enum values
- `lowercase` for local variables, types, structs, unions, and enum names
- `UPPERCASE` can be used for local enum values
- The namespace for farmutils code is `f` for `farmutils`
- Typedefs should only be defined to built-in types or function pointers
- Pointer asterisks should be put next to the type name (`char* str;` instead of `char *str;`)
- Function definitions should use the following style:
  ```c
  void f_somefunc(void) {
      ...
  }
  ```
