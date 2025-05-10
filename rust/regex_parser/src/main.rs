use std::io::{self, Write};
enum RegexToken {
    Literal(char),
    AnyChar,
    ZeroOrMore(Box<RegexToken>),
}
fn parse_pattern(pattern: &str) -> Vec<RegexToken> {
    let mut tokens: Vec<RegexToken> = Vec::new();
    let chars: Vec<char> = pattern.chars().collect();
    let mut i = 0;

    while i < chars.len() {
        match chars[i] {
            '.' => tokens.push(RegexToken::AnyChar),
            '*' => {
                if let Some(prev) = tokens.pop() {
                    tokens.push(RegexToken::ZeroOrMore(Box::new(prev)));
                }
            }
            c => tokens.push(RegexToken::Literal(c)),
        }
        i += 1;
    }
    tokens // Return the tokens vector
}
fn main() {
    print!("Enter a string: ");
    io::stdout().flush().unwrap();

    let mut input = String::new();
    io::stdin()
        .read_line(&mut input)
        .expect("Failed to read line");
    println!("Hello, world!");
}
