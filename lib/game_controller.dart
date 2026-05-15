class GameController {
  // الفيز 1: المصفوفة (0 هو الفراغ)
  List<int> board = [1, 2, 3, 4, 5, 6, 7, 8, 0];

  // الفيز 2: دالة الخلط
  void shuffleBoard() {
    board.shuffle();
  }

  // الفيز 3: منطق الحركة (المحرك الأساسي للعبة)
  // الدالة ترجع (true) إذا تحركت القطعة و (false) إذا الحركة مستحيلة
  bool movePiece(int index) {
    int emptyIndex = board.indexOf(0);

    // فحص هل القطعة المضغوطة بجانب الفراغ (يمين، يسار، فوق، تحت)
    if (_isAdjacent(index, emptyIndex)) {
      // عملية التبديل (Swap)
      int temp = board[index];
      board[index] = board[emptyIndex];
      board[emptyIndex] = temp;
      return true;
    }
    return false;
  }

  // دالة مساعدة لحساب الجوار (Adjacent) في شبكة 3x3
  bool _isAdjacent(int idx1, int idx2) {
    // الفرق 1 يعني بجانبه أفقياً، الفرق 3 يعني بجانبه عمودياً
    int row1 = idx1 ~/ 3;
    int col1 = idx1 % 3;
    int row2 = idx2 ~/ 3;
    int col2 = idx2 % 3;

    int rowDiff = (row1 - row2).abs();
    int colDiff = (col1 - col2).abs();

    return (rowDiff == 1 && colDiff == 0) || (rowDiff == 0 && colDiff == 1);
  }

  // الفيز 4: شرط الفوز
  bool checkWin() {
    List<int> winOrder = [1, 2, 3, 4, 5, 6, 7, 8, 0];
    for (int i = 0; i < board.length; i++) {
      if (board[i] != winOrder[i]) return false;
    }
    return true;
  }
}