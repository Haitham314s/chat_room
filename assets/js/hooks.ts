import { ViewHook } from "phoenix_live_view";
import Highlight from "./hooks/highlight.ts";
import UpdateLineNumbers from "./hooks/update_line_numbers.ts";

const Hooks: Record<string, Partial<ViewHook>> = {};

Hooks.UpdateLineNumbers = UpdateLineNumbers;
Hooks.Highlight = Highlight;

export default Hooks;
