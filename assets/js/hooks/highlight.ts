import hljs from "highlight.js";

import { updateLineNumbers } from "./update_line_numbers";

type CodeBlock = HTMLElement | null;

const Highlight = {
  mounted() {
    const name = this.el.getAttribute("data-name");
    const codeBlock: CodeBlock = this.el.querySelector("pre code");

    if (name && codeBlock) {
      codeBlock.className = codeBlock.className.replace(/language-\S+/g, "");
      codeBlock.classList.add(`language-${this.getSyntaxType(name)}`);

      const trimmed: HTMLElement = this.trimCodeBlock(codeBlock);
      hljs.highlightElement(codeBlock);
      if (trimmed.textContent) updateLineNumbers(trimmed.textContent);
    }
  },

  getSyntaxType(name) {
    const extension = name.split(".").pop();
    switch (extension) {
      case "txt":
        return "text";
      case "json":
        return "json";
      case "html":
        return "html";
      case "heex":
        return "html";
      case "js":
        return "javascript";
      default:
        return "elixir";
    }
  },

  trimCodeBlock(codeBlock: HTMLElement): HTMLElement {
    const lines = codeBlock.textContent?.split("\n");
    if (lines && lines.length > 2) {
      lines.shift();
      lines.pop();
    }

    codeBlock.textContent = lines?.join("\n") ?? "";
    return codeBlock;
  },
};

export default Highlight;
