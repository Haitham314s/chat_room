import { ViewHook } from "phoenix_live_view";

import CopyToClipboard from "./hooks/copy_to_clipboard.ts";
import CurrentYear from "./hooks/current_year.ts";
import Highlight from "./hooks/highlight.ts";
import UpdateLineNumbers from "./hooks/update_line_numbers.ts";

const Hooks: Record<string, Partial<ViewHook>> = {};

Hooks.UpdateLineNumbers = UpdateLineNumbers;
Hooks.Highlight = Highlight;
Hooks.CopyToClipboard = CopyToClipboard;
Hooks.CurrentYear = CurrentYear;

export default Hooks;
