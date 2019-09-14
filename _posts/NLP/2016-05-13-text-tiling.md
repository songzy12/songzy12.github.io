---
layout: post
title: "Text Tiling"
date: 2016-05-13 21:54:28 +0800
comments: true
categories: 

---

```
vi difficulty/text_seg/texttiling/texttiling.py
vi difficulty/text_seg/nltk/texttiling.py
wordseg = '/home/songzy12/ProblemMatch/difficulty/data/textseg/caiwufenxi.wordseg'
stopwords = '/home/songzy12/ProblemMatch/difficulty/res/stopwords.txt' 
```

--- 

nltk: Natural Language Toolkit.

```
Traceback (most recent call last):
  File "texttiling.py", line 38, in <module>
    demo(file_in)
  File "texttiling.py", line 18, in demo
    s, ss, d, b = tt.tokenize(text)
  File "/usr/local/lib/python2.7/dist-packages/nltk/tokenize/texttiling.py", line 104, in tokenize
    token_table = self._create_token_table(tokseqs, nopunct_par_breaks)
  File "/usr/local/lib/python2.7/dist-packages/nltk/tokenize/texttiling.py", line 231, in _create_token_table
    "No paragraph breaks were found(text too short perhaps?)"
ValueError: No paragraph breaks were found(text too short perhaps?)
```

### _mark_paragraph_breaks

```
pattern = re.compile("[ \t\r\f\v]*\n[ \t\r\f\v]*\n[ \t\r\f\v]*")
matches = pattern.finditer(text)
```

`\n\n\t` is notation of paragraph break.

### _create_token_table

```
lowercase_text = text.lower()
# Remove punctuation
nopunct_text = ''.join(c for c in lowercase_text if re.match("[a-z\-\' \n\t]", c))
print len(lowercase_text), len(nopunct_text)

2266250 523827
```

The Chinese characters has all been filtered out.

---

## run_difficulty.sh

```
DIR_CODE_DIFFICULTY=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${DIR_CODE_DIFFICULTY}/text_seg/
python texttiling/texttiling.py course_list
```

```
res directory:/home/songzy12/ProblemMatch/difficulty/res
num_stopwords:749
processing:/home/songzy12/ProblemMatch/difficulty/res/course.list
input: /home/songzy12/ProblemMatch/difficulty/data/textseg/caiwufenxi.wordseg
output: /home/songzy12/ProblemMatch/difficulty/data/textseg/caiwufenxi.textseg
len(lst_word_num_origin) 49
mean_word_num_origin:1701
mean_word_num_filter:700
n:14120 nSeg:48
```

```
cd /home/songzy12/ProblemMatch/difficulty/data/textseg/
python cat.py 
```

## global_conf

```
DEF_ROOT_DATA_PATH = '/home/songzy12/ProblemMatch/difficulty/data'
DEF_DIR_DATA_TEXTSEG = '{0}/textseg'.format(DEF_ROOT_DATA_PATH)
```

## caiwufenxi.wordseg

```
TsinghuaX/80512073_2015X/2015_T1	cb796df9b2584f609a58a3fa8f858031	00:00:17,156 --> 00:00:18,224	刚才我们说到	刚才 我们 说到
```

## utils.py

```
lst_out = [course_id, video_id, json.dumps(lst_seg_rst)]
fd_ot.write('\t'.join(lst_out)+'\n')
```

```
course_id, video_id, lst_seg_rst = line.strip().split('\t')
lst_seg_rst = json.loads(lst_seg_rst)
```

```
fo = open(fname, 'w')
fo.write(wordseg.encode('utf8') + '\n')
```

## texttiling.py

```
obj = TextTiling(w=10,k=5,
         smooth_width=3,smooth_round=1,cutoff=1,
         file_stopwords='%s/stopwords.txt'%DEF_DIR_RES
)
file_course_list = '{0}/course.list'.format(DEF_DIR_RES)
file_in = '{0}/{1}.wordseg'.format(DEF_DIR_DATA_TEXTSEG, course_name)
file_ot = '{0}/{1}.textseg'.format(DEF_DIR_DATA_TEXTSEG, course_name)
obj.proc_file(file_in=file_in, file_ot=file_ot, b_filter=True, b_draw_img=False)
```

## proc_file

```
lst_seg_rst = self.segment_by_video(lst_paragraph, b_draw_img)
dump2file(fot, course_id, video_id, lst_seg_rst)
```

```
seconds = self.get_video_elapse(lst_paragraph)
lst_video_md5.append(lst_paragraph[0][1])
lst_word_num_origin.append(self.get_video_wordnum(lst_paragraph))
if b_filter:
    self.filter_stopwords(lst_paragraph)
lst_word_num_filter.append(self.get_video_wordnum(lst_paragraph))
```

## segment_by_video

```
lst_token_seq = self.get_token_seq(lst_paragraph)
lst_gap_score = self.block_comparison(lst_token_seq)
lst_smooth = self.smooth_scores(lst_gap_score)
lst_depth = self.depth_scores(lst_smooth)
lst_boundary = self.identify_boundary(lst_depth)
lst_post_boundary = self.post_boundary(lst_token_seq, lst_boundary)
sub_text, lst_wordseg = self.get_sub_text(lst_token_seq, lst_paragraph, idx_pre, idx_cur)
```

### get_token_seq

将单词分组.

### block_comparison

```
lst_b1 = get_block_lst(tokseqs, curr_gap-window_size+1, curr_gap+1)
dic_b1 = get_block_dic(lst_b1)
lst_block = merge_lst(lst_b1, lst_b2)

for t in lst_block:
    score_dividend += blk_frq(t, dic_b1)*blk_frq(t, dic_b2)
    score_divisor_b1 += blk_frq(t, dic_b1)**2
score = score_dividend/math.sqrt(score_divisor_b1*score_divisor_b2)
```

### smooth_scores

Wraps the smooth function from the SciPy Cookbook.
Pasted from the SciPy cookbook: http://scipy-cookbook.readthedocs.org/items/SignalSmooth.html.

```
s=numpy.r_[2*x[0]-x[window_len:1:-1],x,2*x[-1]-x[-1:-window_len:-1]]
# Translates slice objects to concatenation along the first axis
w=numpy.ones(window_len,'d')
y=numpy.convolve(w/w.sum(),s,mode='same')
return y[window_len-1:-window_len+1]
```

### depth_socres

```
for gapscore in scores[clip:-clip]
```

计算 depth.

### identify_boundary

```
cutoff = avg-numpy.stdev/2.0
if cutoff < 0.2:
    cutoff = 0.2

# undo if there is a boundary close already
if dt[1] != dt2[1] and abs(dt2[1]-dt[1]) < 10  and boundaries[dt2[1]] == 1:
    boundaries[dt[1]] = 0
```

### post_boundary

```
lst_ret.append(lst_token_seq[idx].index)
```

### get_sub_text

```
str_text += caption_text + '。'
```

---

## Text Tiling

### Tokenization

Sentence Boundaries are not relevant.

Tiles: Equal sized areas of text: sequences of words that contain the same number of words.

Phases:
* Convert text into lower-cases
* Remove punctuation (including end of sentence boundaries)
* Remove numbers and non-alphabetic symbols
* Keep the paragraph breaks
* Mark stop-words (no-deletion)
* Remaining tokens are stemmed
* Divide the text into token sequences of n tokens: Tiles. Usually n = 20.

Example: "He Drives a car or a taxi." => "stopword driv stopword stopword car stopword stopword taxi"

### Similarity determination

Measure how similar two blocks around a potential segment break (gap) are.

One block: k token sequences.

Possible measures:
* Vector Space Model: create two artificial documents from the sequence of tokens at the left and the right of the gap; compute correlation coefficients for the documents (Using their term vectors)
* Vocabulary Introduction: Similarity is measured as the negative of the number of new terms introduced on either side of the gap
* Block Comparison: compute correlation coefficients between left and right blocks based on within-block term frequency (without inverse document frequency) (We will use this method)

Block Comparison:
sim(i) = \frac{\sum_{t\in T}C(t, b_l)\cdot C(t, b_r)} {\sqrt{\sum_{t\in T}C(t,b_l)^2\sum_{t\in T}C(t,b_r)^2}}

Depth Scoring:
Need to observe how similarity scores change (i.e. compare the difference in similarity scores not their absolute value)

Depth(i) = sum(i-1)-sim(i)+sim(i+1)-sim(i)

Smoothing: depth(i) = (depth(i-1)+depth(i)+depth(i+1)) / 3

### Segment break-point identification

Two methods to choose gaps with big depth scores as breakpoints:
* Compute the mean and standard deviation of depth scores and select gaps with depth scores biger than μ – cσ (depending on the data, usually we pick c=0.5 or c=1.0)
* Estimate the number of breakpoints from data: D and pick the D gaps with biggest depths (We’ll use this method)

Token sequences are of predefined length → proposed break points could end up in the middle of a paragraph. In this case, mark the closest paragraph break as a breakpoint ( mark L or R if paragraph break is to the left or right of the gap). Note: If a paragraph break is
marked both with R and L, you are more confidant that it’s a breakpoint.

Discard the breakpoints at occur in consecutive paragraph breaks. But do ensure that at the end there are D breakpoints.

### Evaluation

kappa coefficient: `k > .8` signals good replicability, `.67 < k < .8` allows tentative conclusions to be drawn.

```
k = \frac{P(A)-P(E)}{1-P(E)}
```