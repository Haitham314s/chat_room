import { ViewHook } from "phoenix_live_view";

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
  mounted(this: ViewHook) {
    const lineNumberText: LineNumberTextType =
      document.querySelector("#line-numbers");
    this.el.addEventListener("input", () => {
      updateLineNumbers((<HTMLTextAreaElement>this.el).value);
    });

    this.el.addEventListener("scroll", () => {
      if (lineNumberText !== null) lineNumberText.scrollTop = this.el.scrollTop;
    });

    this.el.addEventListener("keydown", (e) => {
      if (e.key === "Tab") {
        e.preventDefault();
        var start = (<HTMLTextAreaElement>this.el).selectionStart;
        var end = (<HTMLTextAreaElement>this.el).selectionEnd;
        (<HTMLTextAreaElement>this.el).value =
          (<HTMLTextAreaElement>this.el).value.substring(0, start) +
          "\t" +
          (<HTMLTextAreaElement>this.el).value.substring(end);

        (<HTMLTextAreaElement>this.el).selectionStart = (<HTMLTextAreaElement>(
          this.el
        )).selectionEnd = start + 1;
      }
    });

    this.handleEvent("clear-textareas", () => {
      (<HTMLTextAreaElement>this.el).value = "";
      if (lineNumberText !== null) lineNumberText.value = "1\n";
    });

    updateLineNumbers((<HTMLTextAreaElement>this.el).value);
  },
};

export default UpdateLineNumbers;
