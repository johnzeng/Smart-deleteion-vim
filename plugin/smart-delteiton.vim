func! s:SmartDelete_v2()
    let delete_till = s:CalDeleteTillForSmartDelete()
    if delete_till == -100
        return "\<C-w>"
    else
        let cur_line = getline('.')
        let cur_col = col('.')
        let curpos = getpos('.')
        let partA = strpart(cur_line, 0, delete_till)
        let partB = strpart(cur_line, cur_col - 1)
        let new_line = partA . partB
        call setline('.', new_line)
        let curpos[2] = delete_till + 1
        call setpos('.', curpos)
        return ""
    end
endfunc

func! s:CalDeleteTillForSmartDelete()
    let cur_col = col('.')
    let curpos = getpos('.')
    normal b
    let word_head_col = col('.')
    call setpos('.', curpos)
    let cur_line = getline('.')

    "current col is still in input mode, so you should start search from cur_col - 1 col
    "col is not index of cur_line, col - 2 is the index of the cur_col - 1
    let first_upper_case_index = cur_col - 2
    let first_under_score_index = cur_col - 2

    "should not equal the word_head_col's index
    while first_under_score_index >= word_head_col - 1
        if cur_line[first_under_score_index] == '_'
            while first_under_score_index >= word_head_col - 1 && cur_line[first_under_score_index - 1] == '_'
                let first_under_score_index = first_under_score_index - 1
            endwhile
            break
        endif
        let first_under_score_index = first_under_score_index - 1
    endwhile

    "should not equal the word_head_col's index
    if first_under_score_index > word_head_col - 1
        echom first_under_score_index
        if first_under_score_index == cur_col - 2
            let delete_till = first_under_score_index 
        else
            let delete_till = first_under_score_index + 1
        endif
        return delete_till
    endif
        
    "should not equal the word_head_col's index
    while first_upper_case_index >= word_head_col - 1
        if 'A' <= cur_line[first_upper_case_index] && cur_line[first_upper_case_index] <= 'Z'
            while first_upper_case_index >= word_head_col - 1 && 'A' <= cur_line[first_upper_case_index] && cur_line[first_upper_case_index] <= 'Z'
                let first_upper_case_index = first_upper_case_index - 1
            endwhile
            break
        endif
        let first_upper_case_index = first_upper_case_index - 1
    endwhile

    "should not equal the word_head_col's index
    if first_upper_case_index > word_head_col - 1
        let delete_till = first_upper_case_index + 1
        return delete_till
    endif
    return -100
endfunc

if exists('g:smart_delete_key_map')
    let s:cmd = 'imap '.g:smart_delete_key_map.' <C-R>=<SID>SmartDelete_v2()<CR>'
    exec s:cmd
else
    imap <M-w> <C-R>=<SID>SmartDelete_v2()<CR>
endif

