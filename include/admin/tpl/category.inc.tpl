{* HTML5: Yes *}
{* jQuery: No *}

{if $post_save}
    {if $new}
        <span class="msg_success">{$CONST.CATEGORY_SAVED}</span>
    {/if}
    {if $edit}
        {if isset($editPermission) && $editPermission == false}
        <span class="msg_error">{$CONST.PERM_DENIED}</span>
        {else}
        {if $subcat}{$subcat}{else}
        <span class="msg_success">{$CONST.CATEGORY_SAVED}</span>
        {/if}
        {/if}
    {/if}
{/if}
{if $doDelete}
  {if $deleteSuccess}
        <span class="msg_success">{if $remainingCat}{$CONST.CATEGORY_DELETED_ARTICLES_MOVED|sprintf:$remainingCat:$cid}{else}{$cid|string_format:"{$CONST.CATEGORY_DELETED}"}{/if}</span>
  {else}
        <span class="msg_error">{$CONST.INVALID_CATEGORY}</span>
  {/if}
{/if}
{if $delete}
    {if $deletePermission == true}
        <form method="POST" name="serendipityCategory" action="?serendipity[adminModule]=category&amp;serendipity[adminAction]=doDelete&amp;serendipity[cid]={$cid}">
            {$formToken}
            <h2>{$categoryName|escape:"html"}</h2>

            <div class="form_select">
                <label for="remaining_cat">{$CONST.CATEGORY_REMAINING}:</label>
                <select id="remaining_cat" name="serendipity[cat][remaining_catid]">
                    <option value="0">{$CONST.NO_CATEGORY}</option>
                {foreach $cats as $cat_data}
                    <option value="{$cat_data.categoryid}">{$cat_data.category_name|escape:"html"}</option>
                {/foreach}
                </select>
            </div>

            <input type="submit" name="REMOVE" value="{$CONST.GO}">
        </form>
    {/if}
{/if}

{if (! $post_save) && ($edit || $new)}
    {if $edit}
        <h2>{$category_name|escape:"html"|string_format:"{$CONST.EDIT_THIS_CAT}"}</h2>
    {/if}
        <form id="serendipity_category" method="POST" name="serendipityCategory">
            {$formToken}
            <div class="form_field">
                <label for="category_name">{$CONST.NAME}</label>
                <input id="category_name" type="text" name="serendipity[cat][name]" value="{$this_cat.category_name|default:""|escape:"html"}">
            </div>

            <div class="form_field">
                <label for="category_description">{$CONST.DESCRIPTION}</label>
                <input id="category_description" type="text" name="serendipity[cat][description]" value="{$this_cat.category_description|default:""|escape:"html"}">
            </div>

            <div class="form_field">
                <label for="category_icon">{$CONST.IMAGE}</label>
                <input id="category_icon" type="text" name="serendipity[cat][icon]" value="{$this_cat.category_icon|default:""|escape:"html"}" onchange="document.getElementById('imagepreview').src = this.value; document.getElementById('imagepreview').style.display = '';">
                <script type="text/javascript" language="JavaScript">
                    var category_icon = document.getElementById('category_icon');
                    var imgBtn        = document.createElement('div');
                    imgBtn.id         = "insert_image";
                    imgBtn.innerHTML  = '<input type="button" name="insImage" value="{$CONST.IMAGE}" onclick="window.open(\'serendipity_admin_image_selector.php?serendipity[htmltarget]=category_icon&amp;serendipity[filename_only]=true\', \'ImageSel\', \'width=800,height=600,toolbar=no,scrollbars=1,scrollbars,resize=1,resizable=1\');">';
                    category_icon.parentNode.insertBefore(imgBtn, category_icon.nextSibling);
                </script>
                <!-- noscript>FIXXME: Emit a warning if JS is disabled</noscript -->
            </div>

            <figure id="preview">
                <img id="imagepreview" src="{$this_cat.category_icon|default:""|escape:"html"}" alt="">
                <figcaption>{$CONST.PREVIEW}</figcaption>
            </figure>

            <div class="form_multiselect">
                <label for="read_authors">{$CONST.PERM_READ}</label>
                <select id="read_authors" size="6" multiple="multiple" name="serendipity[cat][read_authors][]">
                    <option value="0"{if $selectAllReadAuthors} selected="selected"{/if}>{$CONST.ALL_AUTHORS}</option>
                {foreach $groups as $group}
                    <option value="{$group.confkey}"{if isset($read_groups.{$group.confkey})} selected="selected"{/if} >{$group.confvalue|escape:"html"}</option>
                {/foreach}
                </select>
            </div>

            <div class="form_multiselect">
                <label for="write_authors">{$CONST.PERM_WRITE}</label>
                <select id="write_authors"size="6" multiple="multiple" name="serendipity[cat][write_authors][]">
                    <option value="0"{if $selectAllReadAuthors} selected="selected"{/if}>{$CONST.ALL_AUTHORS}</option>
                {foreach $groups as $group}
                    <option value="{$group.confkey}"{if isset($read_groups.{$group.confkey})} selected="selected"{/if}>{$group.confvalue|escape:"html"}</option>
                {/foreach}
                </select>
            </div>

            <div class="form_select">
                <label for="parent_cat">{$CONST.PARENT_CATEGORY}</label>
                <select id="parent_cat" name="serendipity[cat][parent_cat]">
                    <option value="0"{if $cid == 0} selected="selected"{/if}>{$CONST.NO_CATEGORY}</option>
                {foreach $categories as $cat}
                    {if $cat.categoryid == $cid}{continue}{/if}
                    <option value="{$cat.categoryid}"{if $this_cat.parentid == $cat.categoryid} selected="selected"{/if}>{for $i=1 to $cat.depth}&nbsp{/for} {$cat.category_name}</option>
                {/foreach}
                </select>
            </div>

            <div class="form_field">
                <h3>{$CONST.CATEGORY_HIDE_SUB}</h3>
                <p>{$CONST.CATEGORY_HIDE_SUB_DESC}</p>
                <input id="hide_sub_yes" type="radio" name="serendipity[cat][hide_sub]" value="1"{if $this_cat.hide_sub== 1} checked="checked"{/if}><label for="hide_sub_yes">{$CONST.YES}</label>
                <input id="hide_sub_no" type="radio" name="serendipity[cat][hide_sub]" value="0"{if $this_cat.hide_sub == 0} checked="checked"{/if}><label for="hide_sub_no">{$CONST.NO}</label>
            </div>
            <input type="submit" name="SAVE" value="{$save}">
        </form>
        <script src="serendipity_editor.js"></script>
{/if}
{if $view}
    {if is_array($viewCats)}
        <h2>{$CONST.CATEGORY_INDEX}:</h2>
    {else}
        <span class="msg_notice">{$CONST.NO_CATEGORIES}</span>
    {/if}
        <ul class="plainList">
        {foreach $viewCategories as $category}
        {* TODO: Ideally, this should use true nesting, i.e. nested lists instead of a level class. *}
            <li class="level_{$category.depth}">
                <dl>
                    <dt{if $category.category_icon} class="category_hasicon"{/if}>{$category.category_name|escape:"html"}</dt>
                {if $category.category_description != ''}
                    <dd class="category_desc">{$category.category_description|escape:"html"}</dd>
                {/if}
                    <dd class="category_author">{if $category.authorid == 0}{$CONST.ALL_AUTHORS}{else}{$category.realname|escape:"html"}{/if}</dd>
                </dt>
                <a class="link_edit" href="?serendipity[adminModule]=category&amp;serendipity[adminAction]=edit&amp;serendipity[cid]={$category.categoryid}">{$CONST.EDIT}</a>
                <a class="link_delete" href="?serendipity[adminModule]=category&amp;serendipity[adminAction]=delete&amp;serendipity[cid]={$category.categoryid}">{$CONST.DELETE}</a>
            </li>
        {/foreach}
        </ul>
        <a class="link_create" href="?serendipity[adminModule]=category&serendipity[adminAction]=new">{$CONST.CREATE_NEW_CAT}</a>
{/if}