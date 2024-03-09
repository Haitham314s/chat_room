type LineNumberTextType = HTMLTextAreaElement | null;

export function updateLineNumbers(value: HTMLTextAreaElement["value"]) {
  const lineNumberText: LineNumberTextType =
    document.querySelector("#line-numbers");
  if (!lineNumberText) return;

  const lines = value.split("\n");
  const numbers = lines.map((_, index) => index + 1).join("\n") + "\n";

  lineNumberText.value = numbers;
}

const UpdateLineNumbers = {
  mounted() {
    const lineNumberText: LineNumberTextType =
      document.querySelector("#line-numbers");
    this.el.addEventListener("input", () => {
      updateLineNumbers(this.el.value);
    });

    this.el.addEventListener("scroll", () => {
      if (lineNumberText !== null) lineNumberText.scrollTop = this.el.scrollTop;
    });

    this.el.addEventListener("keydown", (e) => {
      if (e.key === "Tab") {
        e.preventDefault();
        var start = this.el.selectionStart;
        var end = this.el.selectionEnd;
        this.el.value =
          this.el.value.substring(0, start) +
          "\t" +
          this.el.value.substring(end);

        this.el.selectionStart = this.el.selectionEnd = start + 1;
      }
    });

    this.handleEvent("clear-textareas", () => {
      this.el.value = "";
      if (lineNumberText !== null) lineNumberText.value = "1\n";
    });

    updateLineNumbers(this.el.value);
  },
};

export default UpdateLineNumbers;
