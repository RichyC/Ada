WITH Ada.Unchecked_Deallocation;
WITH Ada.Text_IO; USE Ada.Text_IO;

PACKAGE BODY stacks IS

   PROCEDURE delete IS NEW Ada.Unchecked_Deallocation(Object => StackNode, Name => Stack);

   FUNCTION is_Empty(S: Stack) RETURN BOOLEAN IS
      BEGIN
          RETURN S = NULL;
      END is_Empty;

   FUNCTION is_Full(S: Stack) RETURN BOOLEAN IS
      BEGIN
          RETURN FALSE;
      END is_Full;

   PROCEDURE push(Item: ItemType; S : in out Stack) IS
      BEGIN
          IF is_Empty(S) THEN
              S := new StackNode'(Item, NULL);
          ELSE
              S := new StackNode'(Item, S);
          END IF;
      END push;

   PROCEDURE pop(S : in out Stack) IS

      tmp_pointer : Stack;

      BEGIN
          tmp_pointer := S;
          S := S.all.Next;
          delete(tmp_pointer);
      END pop;

   FUNCTION top(S: Stack) RETURN ItemType IS
      BEGIN
          RETURN S.all.Item;
      END top;

   PROCEDURE print(S : in Stack) IS
          currentNode : Stack;
      BEGIN
          currentNode := S;
          WHILE currentNode /= NULL LOOP
              print(currentNode.Item);
              new_line;
              currentNode := currentNode.Next;
          END LOOP;
      END print;

END stacks;

