# Copy this to `~/.jq` (as a file), if you want to automagically include it in every jq program.
# Otherwise you will need to explicitly import/include it.

# https://stackoverflow.com/questions/60148441/format-number-in-thousands-separators-with-jq-json-cli
def h: tostring | [while(length>0; .[:-3]) | .[-3:]] | reverse | join(",");

def tobool: {true: true, false: false}[ . | tostring];

# For `az` Azure CLI
def todate: try (tonumber | strftime("%Y-%m-%d %H:%M:%S")) catch .;

# For `aws` CLI iam get credential report
def age: try (((now - (. | sub("\\+00:00$"; "Z") | fromdateiso8601)) / 60.0 / 60.0 / 24.0) | floor) catch null;

def arrayify: if type=="array" then . else [.] end ;

# https://stackoverflow.com/a/69754759
# Horizontal style table (heading row)
def pretty_table:
 (first | keys_unsorted | ( ., map(length * "-") )), .[] | map(.) | @tsv
  ;

def tw5_table:
 (first | keys_unsorted |  map("!\(.)")), .[] | map(.) | join("|") | sub("^"; "|") | sub("$"; "|")
  ;

# Vertical table, heading column
def table:
  to_entries[] | map(.) | @tsv;
