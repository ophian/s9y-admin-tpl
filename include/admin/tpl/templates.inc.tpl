{* HTML5: Yes *}
{* jQuery: NN *}

{if $adminAction == 'install'}
    <span class="msg_success">{$install_template|string_format:"{$CONST.TEMPLATE_SET}"}</span>
{/if}
{if $deprecated}
    <span class="msg_notice">{$CONST.WARNING_TEMPLATE_DEPRECATED}</span>
{/if}
    <h3>{$CONST.STYLE_OPTIONS} ({$cur_template})</h3>
{if $has_config}
    {if $adminAction == 'configure'}
    <span class="msg_success">{$CONST.DONE}: {$save_time}</span>
    {/if}
    <form method="post" action="serendipity_admin.php">
        <input type="hidden" name="serendipity[adminModule]" value="templates">
        <input type="hidden" name="serendipity[adminAction]" value="configure">
        {$form_token}
        {$configuration}
    </form>
{else}
    <p>{$CONST.STYLE_OPTIONS_NONE}</p>
{/if}
    <h2>{$CONST.SELECT_TEMPLATE}</h2>

    <ul class="plainList">
    {foreach $templates as $template=>$info}
        {if $info.info.engine == 'yes'}{continue}{/if}
        {if !empty($template)}
        <li><h3>{$info.info.name}</h3>
            {if $info.fullsize_preview || $info.preview}
            <div class="preview_image">
                {if $info.fullsize_preview}<a href="{$info.fullsize_preview}">{/if}
                {if $info.preview}<img src="{$info.preview}" alt="" >{/if}
                {if $info.fullsize_preview}</a>{/if}
            </div>
            {/if}
            <dl class="template_info clearfix">
                <dt class="template_author">{$CONST.AUTHOR}:</dt>
                <dd>{$info.info.author}</dd>
                <dt class="template_date">{$CONST.LAST_UPDATED}:</dt>
                <dd>{$info.info.date}</dd>
                <dt class="template_admin">{$CONST.CUSTOM_ADMIN_INTERFACE}:</dt>
                <dd>{$info.info.custom_admin_interface}</dd>
            </dl>
            <div class="template_status">
            {if $template != $cur_template}
                {if !$info.unmetRequirements}
                <a href="?serendipity[adminModule]=templates&amp;serendipity[adminAction]=install&amp;serendipity[theme]={$template}{$info.info.customURI}">{$CONST.SET_AS_TEMPLATE}</a>
                {else}
                <span class="unmet_requirements">{$info.unmetRequirements}></span>
                {/if}
            {else}
                <span class="installed">{$CONST.ALREADY_INSTALLED}</span>
            {/if}
            </div>
        </li>
        {/if}
    {/foreach}
    </ul>
