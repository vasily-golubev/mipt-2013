//      Useful info: В.И. Юров "Assembler 2е издание".
// We can see this array from other modules.
int my_extern_array[3] = {1, 2, 3};

// We will call this function from our asm code.
int my_extern_sum(int a, int b) {
	return a + b;
}
