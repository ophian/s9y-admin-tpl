{* HTML5: Yes *}
{* jQuery: No *}
{if $case_imgedit}
    <span class="msg_notice">{$CONST.PREFERENCE_USE_JS_WARNING}</span>
{/if}
{if $case_sync}
    {if !$perm_adminImagesSync}
    <span class="msg_error">{$CONST.PERM_DENIED}</span>
    {else}
    <span class="msg_notice">{$CONST.WARNING_THIS_BLAHBLAH|replace:'\\n':'<br />'}</span>
    <form method="POST" action="serendipity_admin.php?serendipity[adminModule]=media&amp;serendipity[adminAction]=doSync">
        <fieldset>
            <legend>{$CONST.SYNC_OPTION_LEGEND}</legend>
            <input type="radio" name="serendipity[deleteThumbs]" value="no" checked="checked" id="keepthumbs" />
            <label for="keepthumbs">{$CONST.SYNC_OPTION_KEEPTHUMBS}</label><br />
            <input type="radio" name="serendipity[deleteThumbs]" value="check" id="sizecheckthumbs" />
            <label for="sizecheckthumbs">{$CONST.SYNC_OPTION_SIZECHECKTHUMBS}</label><br />
            <input type="radio" name="serendipity[deleteThumbs]" value="yes" />
            <label for="deletethumbs">{$CONST.SYNC_OPTION_DELETETHUMBS}</label><br />
        </fieldset>
        <div class="form_buttons">
            <input type="submit" name="doSync" value="{$CONST.CREATE_THUMBS}">
            <a href="serendipity_admin.php">{$CONST.ABORT_NOW}</a>
        </div>
    </form>
    {/if}
{/if}
{if $case_doSync}
    {if !$perm_adminImagesSync}
        <span class="msg_error">{$CONST.PERM_DENIED}</span>
    {else}
        <h2>{$CONST.SYNCING}</h2>
        <span class="msg_success">{$print_SYNC_DONE}</span>
        <h2>{$CONST.RESIZING}</h2>
        <span class="msg_success">{$print_RESIZE_DONE}</span>
    {/if}
{/if}
{if $case_delete}
    <p><span class="msg_notice">{$CONST.ABOUT_TO_DELETE_FILE|sprintf:"$file"}</span></p>
    <form id="delete_image" method="get">
        <div class="form_buttons">
            <a href="{$newLoc}">{$CONST.DUMP_IT}</a>
            <a href="{$abortLoc}">{$CONST.ABORT_NOW}</a>
        </div>
    </form>
{/if}
{if $switched_output}
    <form id="delete_image" method="get">
    {if ( $is_delete || $is_multidelete )}
        <p><span class="msg_notice">{$CONST.ABOUT_TO_DELETE_FILES}</span></p>
        {foreach $rip_image AS $ripimg}
        <span class="msg_dialog_ripentry">{$ripimg}</span><br />
        {/foreach}
        <ul class="dialog_delrip">
            <li><a class="link_abort" href="{$smarty.server.HTTP_REFERER|escape}">{$CONST.NOT_REALLY}</a></li>
            <li><a class="link_confirm" href="{$newLoc}">{$CONST.DUMP_IT}</a></li>
        </ul>
    {/if}
    </form>
{/if}
{if $case_rename}
    {if $go_back}
    <input type="button" onclick="history.go(-1);" value="{$CONST.BACK}">
    {else}
    <script>location.href="?serendipity[adminModule]=images&serendipity[adminAction]=default";</script>
    <noscript><a href="?serendipity[adminModule]=images&amp;serendipity[adminAction]=default">{$CONST.DONE}</a></noscript>
    {/if}
{/if}

{* TODO: obsolete? *}
{if $case_properties}
    {** serendipity_showPropertyForm($new_media) **}
{/if}
{* END TODO *}

{if $case_add}
    {if $smarty.post.adminSubAction == 'properties'}
    <script>location.href="?serendipity[adminModule]=images&serendipity[adminAction]=default";</script>
    <noscript><a href="?serendipity[adminModule]=images&amp;serendipity[adminAction]=default">{$CONST.DONE}</a></noscript>
    {else}
    {$showML_add}
    {/if}
{/if}
{if $case_directoryDoDelete}
    {if $print_DIRECTORY_WRITE_ERROR}{$print_DIRECTORY_WRITE_ERROR}{/if}
    {if $ob_serendipity_killPath}{$ob_serendipity_killPath}{/if}
    {if $print_ERROR_NO_DIRECTORY}{$print_ERROR_NO_DIRECTORY}{/if}
{/if}
{if $case_directoryEdit}
    {if !empty($smarty.post.save)}
    {if $ob_serendipity_moveMediaDirectory}{$ob_serendipity_moveMediaDirectory}{/if}
    <span class="msg_notice">{$print_CONST.SETTINGS_SAVED_AT}</span>
    {/if}
    <h3>{$CONST.MANAGE_DIRECTORIES}</h3>

    <form id="image_directory_edit_form" method="POST" action="?serendipity[adminModule]=images&amp;serendipity[adminAction]=directoryEdit&amp;serendipity[dir]={$dir|escape:'html'}">
        {$formtoken}
        <input type="hidden" name="serendipity[oldDir]" value="{$use_dir}">
        <div class="form_field">
            <label for="diredit_new">{$CONST.NAME}</label>
            <input id="diredit_new" type="text" name="serendipity[newDir]" value="{$use_dir}">
        </div>
        <div class="form_select">
            <label for="read_authors">{$CONST.PERM_READ}</label>
            <select size="6" id="read_authors" multiple="multiple" name="serendipity[read_authors][]">
                <option value="0"{if $rgroups} selected="selected"{/if}>{$CONST.ALL_AUTHORS}</option>
            {foreach $groups AS $group}
                <option value="{$group.confkey}"{if isset($read_groups.{$group.confkey})} selected="selected"{/if}>{$group.confvalue|escape:'html'}</option>
            {/foreach}
            </select>
        </div>
        <div class="form_select">
            <label for="write_authors">{$CONST.PERM_WRITE}</label>
            <select size="6" id="write_authors" multiple="multiple" name="serendipity[write_authors][]">
                <option value="0"{if $wgroups} selected="selected"{/if}>{$CONST.ALL_AUTHORS}</option>
            {foreach $groups AS $group}
                <option value="{$group.confkey}"{if isset($write_groups.{$group.confkey})} selected="selected"{/if}>{$group.confvalue|escape:'html'}</option>
            {/foreach}
            </select>
        </div>
        <div class="form_check">
            <input id="setchild" value="true" type="checkbox" name="serendipity[update_children]"{if !empty($smarty.post.update_children) == 'on'} checked="checked"{/if}><label for="setchild">{$CONST.PERM_SET_CHILD}</label>
        </div>
        <input type="submit" name="serendipity[save]" value="{$CONST.SAVE}">
    </form>
{/if}
{if $case_directoryDelete}
    <h3>{$CONST.DELETE_DIRECTORY}</h3>
    <p>{$CONST.DELETE_DIRECTORY_DESC}</p>
    <form id="image_directory_delete_form" method="POST" action="?serendipity[adminModule]=images&amp;serendipity[adminAction]=directoryDoDelete&amp;serendipity[dir]={$dir|escape:'html'}">
        {$formtoken}
        <div class="form_check">
            <label for="diredit_delete">{$CONST.NAME}: {$basename_dir} - {$CONST.FORCE_DELETE}</label>
            <input id="diredit_delete" type="checkbox" name="serendipity[nuke]" value="true">
        </div>
        <p>{$CONST.CONFIRM_DELETE_DIRECTORY|sprintf:$dir|escape:'html'}</p>
        <input name="SAVE" value="{$CONST.DELETE_DIRECTORY}" type="submit">
    </form>
{/if}
{if $case_directoryDoCreate}
    {if $print_DIRECTORY_CREATED}{$print_DIRECTORY_CREATED}{/if}
    {if $print_DIRECTORY_WRITE_ERROR}{$print_DIRECTORY_WRITE_ERROR}{/if}
{/if}
{if $case_directoryCreate}
    <h3>{$CONST.CREATE_DIRECTORY}</h3>
    <p>{$CONST.CREATE_DIRECTORY_DESC}</p>
    <form id="image_directory_create_form" method="POST" action="?serendipity[step]=directoryDoCreate&amp;serendipity[adminModule]=images&amp;serendipity[adminAction]=directoryDoCreate">
        {$formtoken}
        <div class="form_field">
            <label for="dircreate_name">{$CONST.NAME}</label>
            <input id="dircreate_name" type="text" name="serendipity[name]" value="">
        </div>
        <div class="form_select">
            <label for="dircreate_parent">{$CONST.PARENT_DIRECTORY}</label>
            <select id="dircreate_parent" name="serendipity[parent]">
                <option value="">{$CONST.BASE_DIRECTORY}</option>
            {foreach $folders as $folder}
                <option{if $folder.relpath == $get.only_path} selected="selected"{/if} value="{$folder.relpath}">{'&nbsp;'|str_repeat:"($folder.depth*2)"} {$folder.name}</option>
            {/foreach}
            </select>
        </div>
        {serendipity_hookPlugin hookAll=true hook="backend_directory_createoptions" addData=$folders}
        <input name="SAVE" value="{$CONST.CREATE_DIRECTORY}" type="submit">
    </form>
{/if}
{if $case_directorySelect}
    <h3>{$CONST.DIRECTORIES_AVAILABLE}</h3>
    <h4>{$CONST.BASE_DIRECTORY}</h4>

    <ul>
    {foreach $folders as $folder}
        <li class="level_{$folder.depth}">{$folder.name}
            <a class="link_edit" href="?serendipity[adminModule]=images&amp;serendipity[adminAction]=directoryEdit&amp;serendipity[dir]={$folder.relpath|escape:'html'}">$CONST.EDIT}</a>
            <a class="link_delete" href="?serendipity[adminModule]=images&amp;serendipity[adminAction]=directoryDelete&amp;serendipity[dir]={$folder.relpath|escape:'html'}">{$CONST.DELETE}</a></li>
    {/foreach}
    </ul>
    <a class="link_create" href="?serendipity[adminModule]=images&amp;serendipity[adminAction]=directoryCreate">{$CONST.CREATE_NEW_DIRECTORY}</a>
{/if}

{* TODO: obsolete? *}
{if $case_addSelect}
    {** smarty display 'admin/media_upload.tpl' **}
{/if}
{* END TODO *}

{if $case_rotateCW}
    {if $rotate_img_done}
    <script>location.href="{$adminFile_redirect}";</script>
    <noscript><a href="{$adminFile_redirect}">{$CONST.DONE}</a></noscript>
    {/if}
{/if}
{if $case_rotateCCW}
    {if $rotate_img_done}
    <script>location.href="{$adminFile_redirect}";</script>
    <noscript><a href="{$adminFile_redirect}">{$CONST.DONE}</a></noscript>
    {/if}
{/if}
{if $case_scale}
    {if $print_SCALING_IMAGE}<span class="msg_notice">{$print_SCALING_IMAGE}</span>{/if}
    {if $print_serendipity_scaleImg}<span class="msg_notice">{$print_serendipity_scaleImg}</span>{/if}
    <span class="msg_notice">{$CONST.DONE}</span>
    <script>location.href="?serendipity[adminModule]=images&serendipity[adminAction]=default";</script>
    <noscript><a href="?serendipity[adminModule]=images&amp;serendipity[adminAction]=default">{$CONST.DONE}</a></noscript>
{/if}
{if $case_scaleSelect}
    <script>
    <!--
        function rescale(dim, newval) {ldelim}
            var originalWidth  = {$img_width};
            var originalHeight = {$img_height};
            var ratio          = originalHeight/originalWidth;
            var trans          = new Array();
            trans['width']     = new Array('serendipity[height]', ratio);
            trans['height']    = new Array('serendipity[width]', 1/ratio);

            if (document.serendipityScaleForm.elements['auto'].checked == true) {ldelim}
                document.serendipityScaleForm.elements[trans[dim][0]].value=Math.round(trans[dim][1]*newval);
            {rdelim}

                document.getElementsByName('serendipityScaleImg')[0].style.width =
                document.serendipityScaleForm.elements['serendipity[width]'].value+'px';

                document.getElementsByName('serendipityScaleImg')[0].style.height =
                document.serendipityScaleForm.elements['serendipity[height]'].value+'px';

            {rdelim}
    //-->
    </script>

    {if $print_RESIZE_BLAHBLAH}<span class="msg_notice">{$print_RESIZE_BLAHBLAH}</span>{/if}
    {if $print_ORIGINAL_SIZE}<span class="msg_notice">{$print_ORIGINAL_SIZE}</span>{/if}
    <h3>{$CONST.HERE_YOU_CAN_ENTER_BLAHBLAH}</h3>

    <form name="serendipityScaleForm" action="?" method="GET">
        {$formtoken}
        <input type="hidden" name="serendipity[adminModule]" value="images">
        <input type="hidden" name="serendipity[adminAction]" value="scale">
        <input type="hidden" name="serendipity[fid]" value="{$get.fid}">
        <fieldset>
            <legend>{$CONST.NEWSIZE}</legend>
            <div class="form_field">
                <label for="resize_width">TODO_LANG</label>
                <input id="resize_width" type="text" name="serendipity[width]" onchange="rescale('width' , value);" value="{$img_width}">
            </div>
            <div class="form_field">
                <label for="resize_height">TODO_LANG</label>
                <input id="resize_height" type="text" name="serendipity[height]" onchange="rescale('height', value);" value="{$img_height}">
            </div>
        </fieldset>
        <div class="form_check">
            <input id="resize_keepprops" type="checkbox" name="auto" checked="checked">
            <label for="resize_keepprops">{$CONST.KEEP_PROPORTIONS}</label>
        </div>
        <input type="button" name="scale" value="{$CONST.IMAGE_RESIZE}" onclick="if (confirm('{$CONST.REALLY_SCALE_IMAGE}')) document.serendipityScaleForm.submit();">
    </form>
    <img src="{$file}" name="serendipityScaleImg" style="width: {$img_width}px; height: {$img_height}px;" alt="">
{/if}
{if $case_default}
    {if $showML_def}{$showML_def}{/if}
{/if}
