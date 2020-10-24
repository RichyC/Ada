WITH Unchecked_Deallocation;
WITH Ada.Text_IO; USE Ada.Text_IO;

PACKAGE BODY queues IS

   PROCEDURE delete IS NEW Unchecked_Deallocation(Object => QueueNode, Name => QueueNodePointer);

   FUNCTION is_Empty(Q: Queue) RETURN Boolean IS
      BEGIN
          RETURN Q.Front = NULL AND Q.Back = NULL;
      END is_Empty;

   FUNCTION is_Full(Q: Queue) RETURN Boolean IS
      BEGIN
          RETURN False;
      END is_Full;

   FUNCTION size(Q: Queue) RETURN Natural IS
      BEGIN
          RETURN Q.Count;
      END size;

   FUNCTION front(Q: Queue) RETURN ItemType IS
      BEGIN
          RETURN Q.Front.all.Data;
      END front;

   PROCEDURE enqueue (Item: ItemType; Q: in out Queue) IS
      BEGIN
          IF is_Empty(Q) THEN
              Q.Front := new QueueNode'(Item, NULL);
              Q.Back := Q.Front;
          ELSE
              Q.Back.Next := new QueueNode'(Item, NULL);
              Q.Back := Q.Back.Next;
          END IF;
          Q.Count := Q.Count + 1;
      END enqueue;

   PROCEDURE dequeue (Q: in out Queue) IS

          tmp_pointer : QueueNodePointer;

      BEGIN
          IF is_Empty(Q) THEN
              RAISE Queue_Empty WITH "Queue is empty.";
          ELSIF Q.Count = 1 THEN
               tmp_pointer := Q.Front;
               Q.Front := NULL;
               Q.Back := NULL;
               delete(tmp_pointer); 
               Q.Count := Q.Count - 1;
          ELSE
               tmp_pointer := Q.Front;
               Q.Front := Q.Front.Next;
               delete(tmp_pointer);
               Q.Count := Q.Count - 1;
          END IF;
      END dequeue;

   procedure print(Q : in Queue) IS
          currentNode : QueueNodePointer;
      BEGIN
          currentNode := Q.Front;
          WHILE currentNode /= NULL LOOP
              print(currentNode.Data);
              new_line;
              currentNode := currentNode.Next;
          END LOOP;
      END print;

end queues;

