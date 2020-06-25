---
layout: post
title: "Huffman Coding"
date: 2020-06-25T20:34:10+08:00
---

<https://en.wikipedia.org/wiki/Huffman_coding>

> As in other entropy encoding methods, more common symbols are generally represented using fewer bits than less common symbols.
> However, although optimal among methods encoding symbols separately, Huffman coding is not always optimal among all compression methods - it is replaced with arithmetic coding or asymmetric numeral systems if better compression ratio is required.

## Example

Huffman tree generated from the exact frequencies of the text "this is an example of a huffman tree".

![Huffman Tree](/img/Huffman_tree.svg.png)

![Huffman Code](/img/Huffman_tree-Code.png)