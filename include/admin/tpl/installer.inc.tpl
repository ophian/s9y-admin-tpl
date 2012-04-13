{* HTML5: Yes *}
{* jQuery: NN *}

{if $is_errors && is_array($errors)}
    {foreach $errors AS $error}
        <span class="msg_error">{$error}</span>
    {/foreach}
{/if}
{if $getstepint0}
        <h2>{$CONST.WELCOME_TO_INSTALLATION}</h2>

        <h3>{$CONST.FIRST_WE_TAKE_A_LOOK}</h3>

        <p>{$print_ERRORS_ARE_DISPLAYED_IN}</p>

        <h3>{$CONST.PRE_INSTALLATION_REPORT|sprintf:$s9yversion}</h3>

        <div id="diagnose">
            <h4>{$CONST.INTEGRITY}</h4>

            <ul>
            {foreach $installerResultDiagnose_CHECKSUMS AS $cksum}
                <li>{$cksum}</li>
            {/foreach}
            </ul>

            <table>
                <caption>{$CONST.PHP_INSTALLATION}</caption>
                <thead>
                    <tr>
                        <th>TODO_LANG</th>
                        <th>TODO_LANG</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>{$CONST.OPERATING_SYSTEM}</td>
                        <td>{$php_uname}</td>
                    </tr>
                    <tr>
                        <td>{$CONST.WEBSERVER_SAPI}</td>
                        <td>{$php_sapi_name}</td>
                    </tr>
                    <tr>
                        <td>PHP version >= 5.2.6</td>
                        <td>{$installerResultDiagnose_VERSION}</td>
                    </tr>
                    <tr>
                        <td>Database extensions</td>
                        <td>{$installerResultDiagnose_DBTYPE}</td>
                    </tr>
                    <tr>
                        <td>Session extension</td>
                        <td>{$installerResultDiagnose_SESSION}</td>
                    </tr>
                    <tr>
                        <td>PCRE extension</td>
                        <td>{$installerResultDiagnose_PCRE}</td>
                    </tr>
                    <tr>
                        <td>GDlib extension</td>
                        <td>{$installerResultDiagnose_GD}</td>
                    </tr>
                    <tr>
                        <td>OpenSSL extension</td>
                        <td>{$installerResultDiagnose_OPENSSL}</td>
                    </tr>
                    <tr>
                        <td>mbstring extension</td>
                        <td>{$installerResultDiagnose_MBSTR}</td>
                    </tr>
                    <tr>
                        <td>iconv extension</td>
                        <td>{$installerResultDiagnose_ICONV}</td>
                    </tr>
                    <tr>
                        <td>zlib extension</td>
                        <td>{$installerResultDiagnose_ZLIB}</td>
                    </tr>
                    <tr>
                        <td>Imagemagick binary </td>
                        <td>{$installerResultDiagnose_IM}</td>
                    </tr>
                </tbody>
            </table>

            <table>
                <caption>{$CONST.PHPINI_CONFIGURATION}</caption>
                <thead>
                    <tr>
                        <th>&nbsp;</th>
                        <th>{$CONST.RECOMMENDED}</th>
                        <th>{$CONST.ACTUAL}</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>safe_mode</td>
                        <td><strong>OFF</strong></td>
                        <td>{$installerResultDiagnose_SSM}</td>
                    </tr>
                    <tr>
                        <td>register_globals</td>
                        <td><strong>OFF</strong></td>
                        <td>{$installerResultDiagnose_SRG}</td>
                    </tr>
                    <tr>
                        <td>magic_quotes_gpc</td>
                        <td><strong>OFF</strong></td>
                        <td>{$installerResultDiagnose_SMQG}</td>
                    </tr>
                    <tr>
                        <td>magic_quotes_runtime</td>
                        <td><strong>OFF</strong></td>
                        <td>{$installerResultDiagnose_SMQR}</td>
                    </tr>
                    <tr>
                        <td>session.use_trans_sid</td>
                        <td><strong>OFF</strong></td>
                        <td>{$installerResultDiagnose_SSUTS}</td>
                    </tr>
                    <tr>
                        <td>allow_url_fopen</td>
                        <td><strong>ON</strong></td>
                        <td>{$installerResultDiagnose_SAUF}</td>
                    </tr>
                    <tr>
                        <td>file_uploads</td>
                        <td><strong>ON</strong></td>
                        <td>{$installerResultDiagnose_SFU}</td>
                    </tr>
                    <tr>
                        <td>post_max_size</td>
                        <td><strong>10M</strong></td>
                        <td>{$installerResultDiagnose_SPMS}</td>
                    </tr>
                    <tr>
                        <td>upload_max_filesize</td>
                        <td><strong>10M</strong></td>
                        <td>{$installerResultDiagnose_SUMF}</td>
                    </tr>
                    <tr>
                        <td>memory_limit</td>
                        <td><strong>{($CONST.PHP_INT_SIZE == 4) ? '8M' : '16M'}</strong></td>
                        <td>{$installerResultDiagnose_SML}</td>
                    </tr>
                </tbody>
            </table>

            <h4>{$CONST.PERMISSIONS}</h4>

            <h5>{$basedir}</h5>
            <ul>
            {foreach $installerResultDiagnose_WRITABLE AS $fwrite}
                <li>{$fwrite}</li>
            {/foreach}
            </ul>

            <h5>{$basedir} {$CONST.PATH_SMARTY_COMPILE}</h5>
            <ul>
            {foreach $installerResultDiagnose_COMPILE AS $compile}
                <li>{$compile}</li>
            {/foreach}
            </ul>

            <h5>{$basedir}archives/</h5>
            <ul>
            {foreach $installerResultDiagnose_ARCHIVES AS $archives}
                <li>{$archives}</li>
            {/foreach}
            </ul>

            <h5>{$basedir}plugins/</h5>
            <ul>
            {foreach $installerResultDiagnose_PLUGINS AS $plugins}
                <li>{$plugins}</li>
            {/foreach}
            </ul>
        {if $is_dir_uploads}
            <h5>{$basedir}uploads/</h5>
            <ul>
            {foreach $installerResultDiagnose_UPLOADS AS $uploads}
                <li>{$uploads}</li>
            {/foreach}
            </ul>
        {/if}
        {if $is_imb_executable}
            <h5>Execute Imagemagick binary</h5>
            <ul>
            {foreach $installerResultDiagnose_IMB AS $im_binary}
                <li>{$im_binary}</li>
            {/foreach}
            </ul>
        {/if}
        {if $showWritableNote}
            <span class="msg_notice">{$CONST.PROBLEM_PERMISSIONS_HOWTO|sprintf:'chmod 1777'}</span>
        {/if}
        {if $errorCount > 0}
            <span class="msg_error">{$CONST.PROBLEM_DIAGNOSTIC}</span>
            <a href="serendipity_admin.php">{$CONST.RECHECK_INSTALLATION}</a>
        {else}
            <span class="msg_notice">{$CONST.SELECT_INSTALLATION_TYPE}:</span>
            <a href="?serendipity[step]=2a">{$CONST.SIMPLE_INSTALLATION}</a> - <a href="?serendipity[step]=2b">{$CONST.EXPERT_INSTALLATION}</a>
        {/if}
        </div>
{elseif $s9yGETstep == '2a'}
        <form action="?" method="post">
            <input type="hidden" name="serendipity[step]" value="{$s9yGETstep}">
            <input type="hidden" name="serendipity[getstep]" value="3">
            {if $ob_serendipity_printConfigTemplate}{$ob_serendipity_printConfigTemplate}{/if}
            <input name="submit" type="submit" value="{$CONST.COMPLETE_INSTALLATION}">
        </form>
{elseif $s9yGETstep == '2b'}
        <form action="?" method="post">
            <input type="hidden" name="serendipity[step]" value="{$s9yGETstep}">
            <input type="hidden" name="serendipity[getstep]" value="3">
            {if $ob_serendipity_printConfigTemplate}{$ob_serendipity_printConfigTemplate}{/if}
            <input name="submit" type="submit" value="{$CONST.COMPLETE_INSTALLATION}">
        </form>
{elseif $getstepint3}
        <h3>{$CONST.CHECK_DATABASE_EXISTS}</h3>
    {if is_array($authors_query)}
        <span class="msg_success"><strong>{$CONST.THEY_DO}</strong>, {$CONST.WONT_INSTALL_DB_AGAIN}</span>
    {else}
        <span class="msg_error"><strong>{$CONST.THEY_DONT}</strong></span>

        <ol>
            <li>{$CONST.CREATE_DATABASE}{if $install_DB} <strong>{$CONST.DONE}</strong>{/if}</li>
            <li>{$CONST.CREATING_PRIMARY_AUTHOR|sprintf:"{$smarty.post.user|escape}"}{if $add_authors} <strong>{$CONST.DONE}</strong>{/if}</li>
            <li>{$CONST.SETTING_DEFAULT_TEMPLATE}{if $set_template_vars} <strong>{$CONST.DONE}</strong>{/if}</li>
            <li>{$CONST.INSTALLING_DEFAULT_PLUGINS}{if $register_default_plugins} <strong>{$CONST.DONE}</strong>{/if}</li>
        </ol>
    {/if}
        <h3>{$CONST.ATTEMPT_WRITE_FILE|sprintf:'.htaccess'}</h3>
    {if $errors_sif === true}
        <span class="msg_success">{$CONST.DONE}</span>
    {else}
        <h4>{$CONST.FAILED}</h4>
        <ul>
        {foreach $errors_sif AS $error_f}
            <li><span class="msg_error">{$error_f}</span></li>
        {/foreach}
        </ul>
    {/if}
    {if $s9y_installed}
        <span class="msg_success">{$CONST.SERENDIPITY_INSTALLED}</span>
        <p><strong>{$CONST.THANK_YOU_FOR_CHOOSING}</strong></p>
        <a href="{$smarty.post.serendipityHTTPPath}">{$CONST.VISIT_BLOG_HERE}</a>
    {else}
        <span class="msg_error">{$CONST.ERROR_DETECTED_IN_INSTALL}</span>
    {/if}
{/if}
